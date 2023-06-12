//
//  CreateRoomResponseModel.swift
//  Evento
//
//  Created by RAmrayev on 12.06.2023.
//

import Foundation
struct CreateRoomResponseModel: Decodable, Hashable {
    let chatRoomId: String
    enum CodingKeys: String, CodingKey {
        case chatRoomId = "chat_room_id"
    }
}
