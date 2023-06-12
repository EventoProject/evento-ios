//
//  EventItemModel.swift
//  Evento
//
//  Created by Ramir Amrayev on 23.05.2023.
//

import Foundation

struct EventItemModel: Decodable, Hashable {
    let id: Int
    let name: String
    let description: String
    let format: String
    let cost: String
    let date: String
    let imageLink: String
    let createdAt: String
    var isLiked: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case format
        case cost
        case date
        case imageLink = "image_link"
        case createdAt = "created_at"
        case isLiked = "is_liked"
    }
}
