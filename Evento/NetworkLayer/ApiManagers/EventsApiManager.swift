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
}

final class EventsApiManager: EventsApiManagerProtocol {
    private let webService: WebServiceProtocol
    
    init(webService: WebServiceProtocol) {
        self.webService = webService
    }
    
    func getEvents() -> AnyPublisher<EventsResponseModel, NetworkError> {
        webService.request(EventsTarget.events)
    }
}
