//
//  NewsApiManager.swift
//  Evento
//
//  Created by Ramir Amrayev on 13.04.2023.
//

import Foundation
import Combine

protocol NewsApiManagerProtocol {
    func search(serchText: String) -> AnyPublisher<SearchNewsResponseModel, NetworkError>
    func topHeadlines() -> AnyPublisher<SearchNewsResponseModel, NetworkError>
}

final class NewsApiManager: NewsApiManagerProtocol {
    private let webService: WebServiceProtocol
    
    init(webService: WebServiceProtocol) {
        self.webService = webService
    }
    
    func search(serchText: String) -> AnyPublisher<SearchNewsResponseModel, NetworkError> {
        webService.request(NewsTarget.search(searchText: serchText))
    }
    
    func topHeadlines() -> AnyPublisher<SearchNewsResponseModel, NetworkError> {
        webService.request(NewsTarget.topHeadlines)
    }
}
