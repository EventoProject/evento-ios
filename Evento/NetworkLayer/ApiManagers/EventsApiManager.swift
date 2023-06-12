//
//  EventsApiManager.swift
//  Evento
//
//  Created by Ramir Amrayev on 23.05.2023.
//

import Foundation
import Combine

protocol EventsApiManagerProtocol {
    func getEvents() -> AnyPublisher<EventsResponseModel, NetworkError>
    func getEvent(id: Int) -> AnyPublisher<EventResponseModel, NetworkError>
    func getLikes(eventId: Int) -> AnyPublisher<[LikeItemModel], NetworkError>
    func follow(isFollow: Bool, userId: Int) -> AnyPublisher<ResultResponseModel, NetworkError>
    func like(isLike: Bool, eventId: Int) -> AnyPublisher<ResultResponseModel, NetworkError>
    func save(isSave: Bool, eventId: Int) -> AnyPublisher<ResultResponseModel, NetworkError>
    func share(text: String, eventId: Int) -> AnyPublisher<ResultResponseModel, NetworkError>
    func sendComment(text: String, eventId: Int) -> AnyPublisher<ResultResponseModel, NetworkError>
    func getComments(eventId: Int) -> AnyPublisher<[CommentItemModel], NetworkError>
    func deleteComment(commentId: Int) -> AnyPublisher<ResultResponseModel, NetworkError>
    func getLikedEvents() -> AnyPublisher<[EventItemModel], NetworkError>
    func getSharedEvents() -> AnyPublisher<[ShareItemModel], NetworkError>
    func getNotifications() -> AnyPublisher<[NotificationItemModel], NetworkError>
}

final class EventsApiManager: EventsApiManagerProtocol {
    private let webService: WebServiceProtocol
    
    init(webService: WebServiceProtocol) {
        self.webService = webService
    }
    
    func getEvents() -> AnyPublisher<EventsResponseModel, NetworkError> {
        webService.request(EventsTarget.events)
    }
    
    func getEvent(id: Int) -> AnyPublisher<EventResponseModel, NetworkError> {
        webService.request(EventsTarget.event(id: id))
    }
    
    func getLikes(eventId: Int) -> AnyPublisher<[LikeItemModel], NetworkError> {
        webService.request(EventsTarget.likes(eventId: eventId))
    }
    
    func follow(isFollow: Bool, userId: Int) -> AnyPublisher<ResultResponseModel, NetworkError> {
        webService.request(EventsTarget.follow(isFollow: isFollow, userId: userId))
    }
    
    func like(isLike: Bool, eventId: Int) -> AnyPublisher<ResultResponseModel, NetworkError> {
        webService.request(EventsTarget.like(isLike: isLike, eventId: eventId))
    }
    
    func save(isSave: Bool, eventId: Int) -> AnyPublisher<ResultResponseModel, NetworkError> {
        webService.request(EventsTarget.save(isSave: isSave, eventId: eventId))
    }
    
    func share(text: String, eventId: Int) -> AnyPublisher<ResultResponseModel, NetworkError> {
        webService.request(EventsTarget.share(text: text, eventId: eventId))
    }
    
    func sendComment(text: String, eventId: Int) -> AnyPublisher<ResultResponseModel, NetworkError> {
        webService.request(EventsTarget.sendComment(text: text, eventId: eventId))
    }
    
    func getComments(eventId: Int) -> AnyPublisher<[CommentItemModel], NetworkError> {
        webService.request(EventsTarget.comments(eventId: eventId))
    }
    
    func deleteComment(commentId: Int) -> AnyPublisher<ResultResponseModel, NetworkError> {
        webService.request(EventsTarget.deleteComment(commentId: commentId))
    }
    
    func getLikedEvents() -> AnyPublisher<[EventItemModel], NetworkError> {
        webService.request(EventsTarget.likedEvents)
    }
    
    func getSharedEvents() -> AnyPublisher<[ShareItemModel], NetworkError> {
        webService.request(EventsTarget.sharedEvents)
    }
    
    func getNotifications() -> AnyPublisher<[NotificationItemModel], NetworkError> {
        webService.request(EventsTarget.notifications)
    }
}
