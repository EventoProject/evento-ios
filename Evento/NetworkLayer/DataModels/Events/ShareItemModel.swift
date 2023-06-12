//
//  ShareItemModel.swift
//  Evento
//
//  Created by Ramir Amrayev on 12.06.2023.
//

import Foundation

struct ShareItemModel: Decodable, Hashable {
    let userName: String
    let username: String
    let userImageLink: String
    let id: Int
    let userId: Int
    let category: String
    let createdAt: String
    let name: String
    let description: String
    let format: String
    let cost: String
    let date: String
    let imageLink: String
    let sharedAt: String
    let shareDescription: String
    
    enum CodingKeys: String, CodingKey {
        case userName = "user_name"
        case username
        case userImageLink = "user_image_link"
        case id
        case userId = "user_id"
        case category
        case createdAt = "created_at"
        case name
        case description
        case format
        case cost
        case date
        case imageLink = "image_link"
        case sharedAt = "shared_at"
        case shareDescription = "share_description"
    }
}
