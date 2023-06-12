//
//  MyProfileModel.swift
//  Evento
//
//  Created by RAmrayev on 12.06.2023.
//

import Foundation

struct MyProfileModel: Decodable, Hashable {
    let id: Int
    let email: String
    let username: String
    let passwordChangedAt: String
    let name: String
    let createdAt: String
    let imageLink: String
    let subscriptions: Int
    let subscribers: Int
    let events: Int
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id, email, name, username, subscriptions, subscribers, events
        case passwordChangedAt = "password_changed_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case imageLink = "image_link"
    }
}
