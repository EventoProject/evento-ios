//
//  EventsTarget.swift
//  Evento
//
//  Created by Ramir Amrayev on 23.05.2023.
//

import Foundation

enum EventsTarget {
    case events
}

extension EventsTarget: EndpointProtocol {
    var baseURL: String {
        return "http://localhost:8081/"
    }
    
    var path: String {
        switch self {
        case .events:
            return "events"
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .events:
            return .get
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
        default:
            return .request
        }
    }
}
