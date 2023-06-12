//
//  CheckChatRoomExistsModel.swift
//  Evento
//
//  Created by RAmrayev on 12.06.2023.
//

import Foundation

struct CheckChatRoomExistsModel: Decodable, Hashable {
    let existsInDb: Bool
    let existsInWs: Bool
    let chatRoomId: String
    enum CodingKeys: String, CodingKey {
        case existsInDb = "exists_in_db"
        case existsInWs = "exists_in_ws"
        case chatRoomId = "chat_room_id"
    }
}

/*
 {
     "exists_in_db": false,
     "exists_in_ws": false,
     "chat_room_id": "1_4"
 }
 */
