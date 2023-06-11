//
//  ChatDetailsResponseModel.swift
//  Evento
//
//  Created by Ramir Amrayev on 10.06.2023.
//

import Foundation

struct ChatDetailsResponseModel: Decodable, Hashable {
    let id: String
    let firstUserId: Int
    let firstUserName: String
    let firstUserImageLink: String
    let secondUserId: Int
    let secondUserName: String
    let secondUserImageLink: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstUserId = "first_user_id"
        case firstUserName = "first_user_name"
        case firstUserImageLink = "first_user_image_link"
        case secondUserId = "second_user_id"
        case secondUserName = "second_user_name"
        case secondUserImageLink = "second_user_image_link"
    }
}
