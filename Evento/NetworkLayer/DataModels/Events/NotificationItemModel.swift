//
//  NotificationItemModel.swift
//  Evento
//
//  Created by Ramir Amrayev on 13.06.2023.
//

import Foundation

struct NotificationItemModel: Decodable, Hashable {
    let id: Int
    let content: String
    let createdAt: String
    let userId: Int?
    let eventId: Int?
    let type: String
    
    enum CodingKeys: String, CodingKey {
        case id, type
        case content
        case createdAt = "created_at"
        case userId = "user_id"
        case eventId = "event_id"
    }
}
