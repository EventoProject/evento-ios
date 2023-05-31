//
//  LoginResponseModel.swift
//  Evento
//
//  Created by Ramir Amrayev on 14.05.2023.
//

import Foundation

struct LoginResponseModel: Decodable {
    let user: UserModel
    let accessToken: String
    
    enum CodingKeys: String, CodingKey {
        case user
        case accessToken = "access_token"
    }
}
