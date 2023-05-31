//
//  CreateEventPayload.swift
//  Evento
//
//  Created by Ramir Amrayev on 22.05.2023.
//

import Foundation

struct CreateEventPayload: Encodable {
    let name: String
    let description: String
    let category: String
    let format: String
    let cost: String
    let date: String
    let duration: String
    let ageLimit: String
    let websiteLink: String
    let imageBase64: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case description
        case category
        case format
        case cost
        case date
        case duration
        case ageLimit = "age_limit"
        case websiteLink = "website_link"
        case imageBase64 = "image_base64"
    }
}
