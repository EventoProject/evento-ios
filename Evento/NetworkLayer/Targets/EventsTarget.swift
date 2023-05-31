//
//  EventsTarget.swift
//  Evento
//
//  Created by Ramir Amrayev on 23.05.2023.
//

import Foundation

enum EventsTarget {
    case events
    case event(id: Int)
    case likes(eventId: Int)
    case follow(isFollow: Bool, userId: Int)
    case like(isLike: Bool, eventId: Int)
    case save(isSave: Bool, eventId: Int)
    case share(isShare: Bool, eventId: Int)
    case sendComment(text: String, eventId: Int)
    case comments(eventId: Int)
}

extension EventsTarget: EndpointProtocol {
    var baseURL: String {
        return "http://localhost:8081/"
    }
    
    var path: String {
        switch self {
        case .events:
            return "events"
        case let .event(id):
            return "auth/event/\(id)"
        case let .likes(eventId):
            return "event/\(eventId)/likes"
        case let .follow(isFollow, userId):
            return "auth/\(isFollow ? "follow" : "unfollow")/\(userId)"
        case let .like(_, eventId):
            return "auth/like/\(eventId)"
        case let .save(_, eventId):
            return "auth/save/\(eventId)"
        case let .share(_, eventId):
            return "auth/share/\(eventId)"
        case let .sendComment(_, eventId):
            return "auth/comment/\(eventId)"
        case let .comments(eventId):
            return "event/\(eventId)/comments"
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .events, .event, .likes, .comments:
            return .get
        case .follow, .sendComment:
            return .post
        case let .like(isLike, _):
            return isLike ? .post : .delete
        case let .save(isSave, _):
            return isSave ? .post : .delete
        case let .share(isShare, _):
            return isShare ? .post : .delete
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
        case let .sendComment(text, _):
            let bodyParams: [String: Any] = [
                "content": text
            ]
            return .requestParameters(bodyParameters: bodyParams, urlParameters: nil)
        default:
            return .request
        }
    }
}
