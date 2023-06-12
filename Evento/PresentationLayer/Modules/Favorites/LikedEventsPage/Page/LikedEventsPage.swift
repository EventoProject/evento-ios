//
//  LikedEventsPage.swift
//  Evento
//
//  Created by Ramir Amrayev on 07.06.2023.
//

import SwiftUI

struct LikedEventsPage: View {
    @ObservedObject var viewModel: LikedEventsViewModel
    
    var body: some View {
        List(viewModel.events, id: \.self) { event in
            EventItemView(
                event: event,
                didTapLike: { isLiked in
                    viewModel.didTapLike(event: event, isLiked: isLiked)
                },
                didTapOrganizer: {
                    viewModel.didTapOrganizer(event: event)
                },
                didTap: {
                    viewModel.didTap(event: event)
                }
            )
            .listRowSeparator(.hidden)
            .listRowBackground(CustColor.backgroundColor)
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .background(CustColor.backgroundColor)
        .refreshable {
            viewModel.refresh()
        }
    }
}

struct LikedEventsPage_Previews: PreviewProvider {
    static var previews: some View {
        LikedEventsPage(
            viewModel: LikedEventsViewModel(
                apiManager: EventsApiManager(
                    webService: WebService(
                        keychainManager: KeychainManager()
                    )
                )
            )
        )
    }
}
