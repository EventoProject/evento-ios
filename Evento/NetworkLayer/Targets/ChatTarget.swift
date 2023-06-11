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
    case chatDetails(chatId: String)
}

extension ChatTarget: EndpointProtocol {
    var baseURL: String {
        return ApiConstants.baseURL
    }
    
    var path: String {
        switch self {
        case .chats:
            return "auth/chats"
        case let .chatHistory(chatId):
            return "auth/chat/\(chatId)/history"
        case let .chatDetails(chatId):
            return "auth/chat/\(chatId)"
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .chats, .chatHistory, .chatDetails:
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
