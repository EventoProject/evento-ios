//
//  WebService.swift
//  Evento
//
//  Created by Ramir Amrayev on 13.04.2023.
//

import Foundation
import Combine

protocol WebServiceProtocol {
    func request<T: Decodable>(_ endpoint: EndpointProtocol) -> AnyPublisher<T, NetworkError>
    func flushToken()
    func set(accessToken: String)
}

class WebService: WebServiceProtocol {
    private var isTokenExpired = false
    private let keychainManager: KeychainManagerProtocol
    
    init(keychainManager: KeychainManagerProtocol) {
        self.keychainManager = keychainManager
    }
    
    func request<T: Decodable>(_ endpoint: EndpointProtocol) -> AnyPublisher<T, NetworkError> {
        guard var components = URLComponents(string: endpoint.baseURL + endpoint.path) else {
            return Fail(error: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        }

        var request = URLRequest(url: URL(string: endpoint.baseURL)!)
        switch endpoint.task {
        case .request:
            break // Do nothing
        case .requestParameters(let bodyParameters, let urlParameters):
            if let queryParameters = urlParameters {
                components.queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: String(describing: $0.value)) }
            }
            if let body = bodyParameters {
                request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
            }
        case .multipartFormData(let bodyParameters, let urlParameters):
            if let queryParameters = urlParameters {
                components.queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: String(describing: $0.value)) }
            }
            let boundary = UUID().uuidString
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            if let body = bodyParameters {
                request.httpBody = createBody(parameters: body, boundary: boundary)
            }
        case .requestJSONEncodable(let encodable):
            do {
                request.httpBody = try JSONEncoder().encode(encodable)
            } catch {
                return Fail(error: NetworkError.encodingFailed)
                    .eraseToAnyPublisher()
            }
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        guard let url = components.url else {
            return Fail(error: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        }

        request.url = url
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.headers ?? [:]
        if let token = keychainManager.getString(type: .accessToken) {
            request.allHTTPHeaderFields?["Authorization"] = "Bearer \(token)"
        }
        print(request.description) // For printing curl

        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkError.invalidResponse
                }
                guard 200..<300 ~= httpResponse.statusCode else {
                    if httpResponse.statusCode == 401 {
                        if !self.isTokenExpired {
                            self.isTokenExpired = true
                            self.handleSessionExpiration()
                        }
                    }
                    
                    self.printErrorResponse(data: data)
                    throw NetworkError.requestFailed(errorText: self.getErrorText(data: data))
                }
                return data
            }
            .flatMap { data -> AnyPublisher<T, Error> in
                if let responseData = try? JSONSerialization.jsonObject(with: data, options: []),
                   let jsonData = try? JSONSerialization.data(withJSONObject: responseData, options: .prettyPrinted),
                   let jsonString = String(data: jsonData, encoding: .utf8) {
                    // Printing received response in JSON format
                    print("Received Response (JSON):")
                    print(jsonString)
                }

                return Just(data)
                    .decode(type: T.self, decoder: JSONDecoder())
                    .eraseToAnyPublisher()
            }
            .mapError { error in
                if let networkError = error as? NetworkError {
                    return networkError
                } else if error is DecodingError {
                    print("\(NetworkError.incorrectJSON) \(error)")
                    return NetworkError.incorrectJSON
                } else {
                    return NetworkError.invalidResponse
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func flushToken() {
        keychainManager.delete(type: .accessToken)
    }
    
    func set(accessToken: String) {
        keychainManager.set(value: accessToken, type: .accessToken)
    }
}

private extension WebService {
    func handleSessionExpiration() {
        DispatchQueue.main.async {
            Application.shared.reauthorize()
        }
    }
    
    func createBody(parameters: [String: Any]?, boundary: String) -> Data {
        let body = NSMutableData()
        guard let parameters else { return body as Data }
        for (key, value) in parameters {
            if let dict = value as? NSDictionary {
                for (multiFileKey, multiFileValue) in dict {
                    if let data = multiFileValue as? Data {
                        let mimeTypeLocal = mimeType(for: data)
                        body.append(Data("--\(boundary)\r\n".utf8))
                        body.append(Data("Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(multiFileKey).jpeg\"\r\n".utf8))
                        body.append(Data("Content-Type: \(mimeTypeLocal)\r\n\r\n".utf8))
                        body.append(data)
                        body.append(Data("\r\n".utf8))
                    }
                }
            } else if let data = value as? Data {
                let mimeTypeLocal = mimeType(for: data)
                body.append(Data("--\(boundary)\r\n".utf8))
                body.append(Data("Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(value).jpeg\"\r\n".utf8))
                body.append(Data("Content-Type: \(mimeTypeLocal)\r\n\r\n".utf8))
                body.append(data)
                body.append(Data("\r\n".utf8))
            } else {
                body.append(Data("--\(boundary)\r\n".utf8))
                body.append(Data("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".utf8))
                body.append(Data("\(value)\r\n".utf8))
            }
        }
        body.append(Data("--\(boundary)--\r\n".utf8))
        
        return body as Data
    }
    
    func mimeType(for data: Data) -> String {
        var b: UInt8 = 0
        data.copyBytes(to: &b, count: 1)
        switch b {
        case 0xFF:
            return "image/jpeg"
        case 0x89:
            return "image/png"
        case 0x47:
            return "image/gif"
        case 0x4D, 0x49:
            return "image/tiff"
        case 0x25:
            return "application/pdf"
        case 0xD0:
            return "application/vnd"
        case 0x46:
            return "text/plain"
        default:
            return "application/octet-stream"
        }
    }
    
    func printErrorResponse(data: Data) {
        // Print error response if available
        if let jsonString = String(data: data, encoding: .utf8) {
            print("Received Error Response (JSON):")
            print(jsonString)
        }
    }
    
    func getErrorText(data: Data) -> String {
        // Decode error
        if let errorModel = try? JSONDecoder().decode(ErrorResponseModel.self, from: data) {
            return errorModel.error
        } else {
            return "Something went wrong"
        }
    }
}
