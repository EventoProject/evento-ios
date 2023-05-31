//
//  NewsTarget.swift
//  Evento
//
//  Created by Ramir Amrayev on 13.04.2023.
//

import Foundation

private enum Constants {
    static let apiKey = "e1edc9b4e5eb4fffa3596371052d7a12"
}

enum NewsTarget {
    case search(searchText: String)
    case topHeadlines
}

extension NewsTarget: EndpointProtocol {
    var baseURL: String {
        return "https://newsapi.org/v2/"
    }
    
    var path: String {
        switch self {
        case .search:
            return "everything"
        case .topHeadlines:
            return "top-healines"
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .search, .topHeadlines:
            return .get
        }
    }
    
    var headers: [String : String]? {
        nil
    }
    
    var task: HTTPTask {
        switch self {
        case let .search(searchText):
            let parameters: [String: Any] = [
                "apiKey": Constants.apiKey,
                "q": searchText,
                "page": 2
            ]
            return .requestParameters(bodyParameters: nil, urlParameters: parameters)
        case .topHeadlines:
            let parameters: [String: Any] = [
                "apiKey": Constants.apiKey
            ]
            return .requestParameters(bodyParameters: nil, urlParameters: parameters)
        }
    }
}
