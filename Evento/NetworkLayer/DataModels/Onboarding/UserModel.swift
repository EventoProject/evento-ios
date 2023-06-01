//
//  UserModel.swift
//  Evento
//
//  Created by Ramir Amrayev on 16.05.2023.
//

import Foundation

struct UserModel: Decodable, Hashable {
    let id: Int
    let email: String
    let passwordChangedAt: String
    let isCommercial: Bool
    let name: String
    let createdAt: String
    let imageLink: String
    
    enum CodingKeys: String, CodingKey {
        case id, email, name
        case passwordChangedAt = "password_changed_at"
        case isCommercial = "is_commercial"
        case createdAt = "created_at"
        case imageLink = "image_link"
    }
}
