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
    let id: Int
    let name: String
    let username: String
    let imageLink: ImageLinkModel
    let isFollowing: Bool
    
    enum CodingKeys: String, CodingKey {
        case id, name, username
        case imageLink = "image_link"
        case isFollowing = "is_following"
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
