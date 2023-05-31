//
//  RegisterPayload.swift
//  Evento
//
//  Created by Ramir Amrayev on 16.05.2023.
//

import Foundation

struct RegisterPayload: Encodable {
    let username: String
    let email: String
    let password: String
    let name: String
    let isCommercial: Bool
    
    enum CodingKeys: String, CodingKey {
        case email, username, password, name
        case isCommercial = "is_commercial"
    }
}
