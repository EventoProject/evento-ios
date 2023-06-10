//
//  ChatTarget.swift
//  Evento
//
//  Created by Ramir Amrayev on 10.06.2023.
//

import Foundation

enum ChatTarget {
    case chats
    case chatHistory(chatId: String)
}

extension ChatTarget: EndpointProtocol {
    var baseURL: String {
        return "http://localhost:8081/"
    }
    
    var path: String {
        switch self {
        case .chats:
            return "auth/chats"
        case let .chatHistory(chatId):
            return "auth/chat/\(chatId)/history"
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .chats, .chatHistory:
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
