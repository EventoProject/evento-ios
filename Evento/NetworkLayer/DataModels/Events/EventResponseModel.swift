//
//  EventResponseModel.swift
//  Evento
//
//  Created by Ramir Amrayev on 30.05.2023.
//

import Foundation

struct EventResponseModel: Decodable {
    let id: Int
    let name: String
    let category: String
    let description: String
    let format:  String
    let cost: String
    let date: String
    let duration: String
    let ageLimit: String
    let websiteLink: String
    let createdAt: String
    let imageLink: String
    var likes: Int
    var comments: Int
    var liked: Bool
    var saved: Bool
    
    enum CodingKeys: String, CodingKey {
        case id, name, category, description, format, cost, date, duration, likes, comments, liked, saved
        case ageLimit = "age_limit"
        case websiteLink = "website_link"
        case createdAt = "created_at"
        case imageLink = "image_link"
    }
}
