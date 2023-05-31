//
//  LikesResponseModel.swift
//  Evento
//
//  Created by Ramir Amrayev on 30.05.2023.
//

import Foundation

struct LikesResponseModel: Decodable {
    let likes: [LikeItemModel]
}

struct LikeItemModel: Decodable, Hashable {
    let createdAt: CreatedAtModel
    let id: Int
    let name: String
    let username: String
    let imageLink: ImageLinkModel
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case id, name, username
        case imageLink = "image_link"
    }
}

struct CreatedAtModel: Decodable, Hashable {
    let time: String
    let valid: Bool
    
    enum CodingKeys: String, CodingKey {
        case time = "Time"
        case valid = "Valid"
    }
}
