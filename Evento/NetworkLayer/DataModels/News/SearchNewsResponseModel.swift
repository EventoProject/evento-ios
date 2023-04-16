//
//  SearchNewsResponseModel.swift
//  Evento
//
//  Created by Ramir Amrayev on 13.04.2023.
//

import Foundation

struct SearchNewsResponseModel: Decodable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]
}

struct Article: Decodable, Hashable {
    struct Source: Decodable {
        let id: Int?
        let name: String
    }
    
    let author: String?
    let title: String
    let description: String
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String
}
