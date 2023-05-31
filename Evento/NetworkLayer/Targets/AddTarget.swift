//
//  AddTarget.swift
//  Evento
//
//  Created by Ramir Amrayev on 22.05.2023.
//

import Foundation

import UIKit

enum AddTarget {
    case categories
    case createEvent(_ payload: CreateEventPayload)
}

extension AddTarget: EndpointProtocol {
    var baseURL: String {
        return "http://localhost:8081/"
    }
    
    var path: String {
        switch self {
        case .categories:
            return "categories"
        case .createEvent:
            return "auth/event"
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .categories:
            return .get
        case .createEvent:
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
        case let .createEvent(payload):
            return .requestJSONEncodable(payload)
        default:
            return .request
        }
    }
}
