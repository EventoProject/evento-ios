//
//  LikedEventsResponseModel.swift
//  Evento
//
//  Created by Ramir Amrayev on 07.06.2023.
//

import Foundation

struct LikedEventsResponseModel: Decodable {
    let likedEvents: [EventItemModel]
    
    enum CodingKeys: String, CodingKey {
        case likedEvents = "liked_events"
    }
}
