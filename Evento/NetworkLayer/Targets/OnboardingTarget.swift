//
//  OnboardingTarget.swift
//  Evento
//
//  Created by Ramir Amrayev on 13.05.2023.
//

import Foundation

enum OnboardingTarget {
    case login(email: String, password: String)
    case register(payload: RegisterPayload)
}

extension OnboardingTarget: EndpointProtocol {
    var baseURL: String {
        return "http://localhost:8081/"
    }
    
    var path: String {
        switch self {
        case .login:
            return "login"
        case .register:
            return "register"
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .login, .register:
            return .post
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return nil
        }
    }
    
    var task: HTTPTask {
        switch self {
        case let .login(email, password):
            let bodyParams: [String: Any] = [
                "email": email,
                "password": password
            ]
            return .requestParameters(bodyParameters: bodyParams, urlParameters: nil)
        case let .register(payload):
            return .requestJSONEncodable(payload)
        }
    }
}
