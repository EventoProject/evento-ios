//
//  UploadProfileImageResponseModel.swift
//  Evento
//
//  Created by Ramir Amrayev on 19.05.2023.
//

import Foundation

struct UploadProfileImageResponseModel: Decodable {
    let result: String
    let imageLink: String
    
    enum CodingKeys: String, CodingKey {
        case result
        case imageLink = "image_link"
    }
}
