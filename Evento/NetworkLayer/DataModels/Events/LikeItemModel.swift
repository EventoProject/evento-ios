//
//  LikeItemModel.swift
//  Evento
//
//  Created by Ramir Amrayev on 12.06.2023.
//

import Foundation

struct LikeItemModel: Decodable, Hashable {
    let id: Int
    let name: String
    let username: String
    let imageLink: String
    let isFollowing: Bool
    
    enum CodingKeys: String, CodingKey {
        case id, name, username
        case imageLink = "image_link"
        case isFollowing = "is_following"
    }
}
