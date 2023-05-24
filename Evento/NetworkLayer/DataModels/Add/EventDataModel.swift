//
//  CreateEventResponseModel.swift
//  Evento
//
//  Created by Ramir Amrayev on 22.05.2023.
//

import Foundation

struct EventDataModel: Decodable {
    let id: Int
    let name: String
    let description: String
    let format: String
    let cost: String
    let date: String
    let duration: String
    let ageLimit: String
    let createdAt: String
    let imageLink: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case format
        case cost
        case date
        case duration
        case ageLimit = "age_limit"
        case createdAt = "created_at"
        case imageLink = "image_link"
    }
}
