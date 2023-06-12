//
//  CommentItemModel.swift
//  Evento
//
//  Created by Ramir Amrayev on 12.06.2023.
//

import Foundation

struct CommentItemModel: Decodable, Hashable {
    let userId: Int
    let name: String
    let username: String
    let imageLink: String
    let commentId: Int
    let createdAt: String
    let content: String
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case imageLink = "image_link"
        case commentId = "comment_id"
        case createdAt = "created_at"
        case name, username, content
    }
}
