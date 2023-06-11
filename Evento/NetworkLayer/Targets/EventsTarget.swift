//
//  EventsTarget.swift
//  Evento
//
//  Created by Ramir Amrayev on 23.05.2023.
//

import Foundation

enum EventsTarget {
    case events
    case myEvents
    case subscriptions
    case subscribers
    case event(id: Int)
    case getUsersSharedEvents(id: Int)
    case likes(eventId: Int)
    case follow(isFollow: Bool, userId: Int)
    case like(isLike: Bool, eventId: Int)
    case save(isSave: Bool, eventId: Int)
    case share(text: String, eventId: Int)
    case sendComment(text: String, eventId: Int)
    case comments(eventId: Int)
    case deleteComment(commentId: Int)
    case likedEvents
}

extension EventsTarget: EndpointProtocol {
    var baseURL: String {
        return "http://localhost:8081/"
    }
    
    var path: String {
        switch self {
        case .events:
            return "auth/events"
        case .myEvents:
            return "auth/my-events"
        case .subscribers:
            return "auth/subscribers"
        case .subscriptions:
            return "auth/subscriptions"
        case let .event(id):
            return "auth/event/\(id)"
        case let .likes(eventId):
            return "auth/event/\(eventId)/likes"
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
        case let .deleteComment(commentId):
            return "auth/comment/\(commentId)"
        case .likedEvents:
            return "auth/liked-events"
        case let .getUsersSharedEvents(id):
            return "auth/shares/\(id)"
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .events, .myEvents, .event, .likes, .comments, .likedEvents, .subscriptions, .subscribers, .getUsersSharedEvents:
            return .get
        case .follow, .sendComment:
            return .post
        case let .like(isLike, _):
            return isLike ? .post : .delete
        case let .save(isSave, _):
            return isSave ? .post : .delete
        case .share:
            return .post
        case .deleteComment:
            return .delete
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
        case .events:
            let urlParams: [String: Any] = [
                "firstSubscriptionsEvents": true
            ]
            return .requestParameters(bodyParameters: nil, urlParameters: urlParams)
        case let .share(text, _):
            let bodyParams: [String: Any] = [
                "description": text
            ]
            return .requestParameters(bodyParameters: bodyParams, urlParameters: nil)
        default:
            return .request
        }
    }
}
