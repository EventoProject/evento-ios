//
//  MyEventsResponseModel.swift
//  Evento
//
//  Created by RAmrayev on 31.05.2023.
//

import Foundation

struct MyEventsResponseModel: Decodable {
    let events: [EventItemModel]
    let accessToken: String
}

