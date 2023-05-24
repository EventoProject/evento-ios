//
//  EventViewModel.swift
//  Evento
//
//  Created by Ramir Amrayev on 24.05.2023.
//

import Foundation

final class EventViewModel: ObservableObject {
    let event: EventItemModel
    
    init(event: EventItemModel) {
        self.event = event
    }
}
