//
//  MessageModel.swift
//  Evento
//
//  Created by Ramir Amrayev on 10.06.2023.
//

import Foundation

struct MessageModel: Decodable, Hashable {
    let id: Int
    let content: String
    let chatRoomId: String
    let senderId: Int
    let sentAt: String
    let lastModifiedAt: String
    let edited: Bool
    let type: Int
    
    enum CodingKeys: String, CodingKey {
        case id, content, edited, type
        case chatRoomId = "chat_room_id"
        case senderId = "sender_id"
        case sentAt = "sent_at"
        case lastModifiedAt = "last_modified_at"
    }
}
