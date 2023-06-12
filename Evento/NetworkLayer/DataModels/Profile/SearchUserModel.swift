//
//  SearchUserModel.swift
//  Evento
//
//  Created by RAmrayev on 10.06.2023.
//

import Foundation

struct SearchUserModel: Decodable, Hashable {
    let id: Int
    let name: String
    let username: String
    let imageLink: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, username
        case imageLink = "image_link"
    }
}
