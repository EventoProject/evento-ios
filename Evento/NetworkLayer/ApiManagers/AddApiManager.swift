//
//  AddApiManager.swift
//  Evento
//
//  Created by Ramir Amrayev on 22.05.2023.
//

import Foundation
import Combine

protocol AddApiManagerProtocol {
    func getCategories() -> AnyPublisher<CategoriesResponseModel, NetworkError>
    func createEvent(_ payload: CreateEventPayload) -> AnyPublisher<EventDataModel, NetworkError>
}

final class AddApiManager: AddApiManagerProtocol {
    private let webService: WebServiceProtocol
    
    init(webService: WebServiceProtocol) {
        self.webService = webService
    }
    
    func getCategories() -> AnyPublisher<CategoriesResponseModel, NetworkError> {
        webService.request(AddTarget.categories)
    }
    
    func createEvent(_ payload: CreateEventPayload) -> AnyPublisher<EventDataModel, NetworkError> {
        webService.request(AddTarget.createEvent(payload))
    }
}
