//
//  EventPage.swift
//  Evento
//
//  Created by Ramir Amrayev on 24.05.2023.
//

import SwiftUI

struct EventPage: View {
    let viewModel: EventViewModel
    
    var body: some View {
        Text(viewModel.event.name)
    }
}

struct EventPage_Previews: PreviewProvider {
    static var previews: some View {
        EventPage(viewModel: EventViewModel(event: EventItemModel(
            id: 0,
            name: "IT forum - Digital Almaty",
            description: "One of the biggest It forums in Central Asia",
            format: "Offline",
            cost: "Free",
            date: "23.05.2023 20:44",
            duration: "2 hours",
            ageLimit: "16+",
            imageLink: ImageLinkModel(
                string: "https://evento-kz.s3.eu-north-1.amazonaws.com/events/f33d921c-6760-48b2-9d2a-75082410ec4c.jpg",
                valid: true
            ),
            createdAt: "2023-05-23T14:45:17.24142Z"
        )))
    }
}
