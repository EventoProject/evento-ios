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
    case checkChatRoomExists(userID: Int)
    case createRoom(userID: Int)
    case restoreRoom(userID: Int)
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
        case let .checkChatRoomExists(userID):
            return "auth/ws/room?userId=\(userID)"
        case let .createRoom(userID):
            return "auth/ws/room/create?userId=\(userID)"
        case let .restoreRoom(userID):
            return "auth/ws/room/restore?userId=\(userID)"
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .chats, .chatHistory, .chatDetails, .checkChatRoomExists:
            return .get
        case .createRoom, .restoreRoom:
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
        default:
            return .request
        }
    }
}
