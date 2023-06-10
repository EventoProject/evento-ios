//
//  ChatsResponseItemModel.swift
//  Evento
//
//  Created by Ramir Amrayev on 10.06.2023.
//

import Foundation

struct ChatsResponseItemModel: Decodable, Hashable {
    let id: String
    let userId: Int
    let userName: String
    let userImageLink: String
    let lastMessageSenderId: Int
    let lastMessageContent: String
    let lastMessageSentAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case userName = "user_name"
        case userImageLink = "user_image_link"
        case lastMessageSenderId = "last_message_sender_id"
        case lastMessageContent = "last_message_content"
        case lastMessageSentAt = "last_message_sent_at"
    }
}
