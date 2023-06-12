//
//  SearchUsersResponseModel.swift
//  Evento
//
//  Created by RAmrayev on 10.06.2023.
//

import Foundation

struct SearchUsersResponseModel: Decodable {
    let users: [SearchUserModel]
    
    enum CodingKeys: String, CodingKey {
        case users
    }
}
