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
    let name: String
    let username: String
    let createdAt: String
    let imageLink: String
//    let events : Int
    enum CodingKeys: String, CodingKey {
        case id, email, name, username
        case passwordChangedAt = "password_changed_at"
        case createdAt = "created_at"
        case imageLink = "image_link"
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
/*
    "id": 1,
    "email": "user11@gmail.com",
    "username": "user11nickname",
    "name": "User 11 ",
    "password_changed_at": "2023-06-10T13:16:38.004967Z",
    "created_at": "2023-06-10T13:16:38.004967Z",
    "updated_at": "2023-06-10T13:16:38.004967Z",
    "image_link": "",
    "subscriptions": 0,
    "subscribers": 0,
    "events": 0
 */
/*
 CustText(
     text: message.sentAt.toDate(with: .yyyyMMddTHHmmssSSSZ)?.toString(format: .hhmm) ?? "",
     weight: .regular,
     size: 14
 )
 */
