//
//  ImageLinkModel.swift
//  Evento
//
//  Created by Ramir Amrayev on 12.06.2023.
//

import Foundation

struct ImageLinkModel: Decodable, Hashable {
    let string: String
    let valid: Bool
    
    enum CodingKeys: String, CodingKey {
        case string = "String"
        case valid = "Valid"
    }
}
