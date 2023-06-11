//
//  ProfileModel.swift
//  Evento
//
//  Created by RAmrayev on 11.06.2023.
//

import Foundation

struct ProfileModel: Decodable, Hashable {
    let email: String
    let passwordChangedAt: String
    let name: String
    let createdAt: String
    let imageLink: String
    let isCommercial: Bool
    var following: Bool
    let subscriptions: Int
    let subscribers: Int
    let events: Int
    let updatedAt: String
//    let events : Int
    enum CodingKeys: String, CodingKey {
        case email, name, subscriptions, subscribers, events, following
        case passwordChangedAt = "password_changed_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case imageLink = "image_link"
        case isCommercial = "is_commercial"
    }
}


/*
 {
     "email": "user11@gmail.com",
     "name": "User 11",
     "is_commercial": false,
     "password_changed_at": "2023-06-11T09:07:38.997187Z",
     "subscriptions": 0,
     "subscribers": 0,
     "events": 0,
     "created_at": "2023-06-11T09:07:38.997187Z",
     "updated_at": "2023-06-11T09:07:38.997187Z",
     "image_link": "",
     "following": false
 }
 */
