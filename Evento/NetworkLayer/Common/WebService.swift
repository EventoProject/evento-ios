//
//  WebService.swift
//  Evento
//
//  Created by Ramir Amrayev on 13.04.2023.
//

import Foundation
import Combine

class WebService {
    func request<T: Decodable>(_ endpoint: BaseProviderType) -> AnyPublisher<T, NetworkError> {
        guard var components = URLComponents(string: endpoint.baseURL + endpoint.path) else {
            return Fail(error: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        }
        
        if let queryParameters = endpoint.parameters {
            components.queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: String(describing: $0.value)) }
        }
        
        guard let url = components.url else {
            return Fail(error: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.headers
        request.httpBody = endpoint.body
        print(request) // For printing curl
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkError.invalidResponse
                }
                guard 200..<300 ~= httpResponse.statusCode else {
                    throw NetworkError.requestFailed
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
}
