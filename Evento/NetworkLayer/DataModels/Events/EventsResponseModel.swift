//
//  EventsResponseModel.swift
//  Evento
//
//  Created by Ramir Amrayev on 23.05.2023.
//

import Foundation

struct EventsResponseModel: Decodable {
    let events: [EventItemModel]
}
