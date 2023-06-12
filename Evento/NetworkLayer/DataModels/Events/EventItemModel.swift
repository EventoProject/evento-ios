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
    var liked: Bool
    let userId: Int
    let userName: String
    let userImageLink: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case format
        case cost
        case date
        case liked
        case imageLink = "image_link"
        case createdAt = "created_at"
        case userId = "user_id"
        case userName = "user_name"
        case userImageLink = "user_image_link"
    }
}
