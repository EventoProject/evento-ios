//
//  EventsPage.swift
//  Evento
//
//  Created by Ramir Amrayev on 01.05.2023.
//

import SwiftUI

struct EventsPage: View {
    @ObservedObject var viewModel: EventsViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            SegementedControlView(
                selectedItem: $viewModel.selectedSegmentedControlItem,
                items: viewModel.segmentedControlItems
            )
            .padding(.vertical, 16)
            .padding(.horizontal, 27)
            .background(CustColor.backgroundColor)
            
            if viewModel.selectedSegmentedControlItem == "All events" {
                allEventsList
            } else {
                sharesList
            }
        }
    }
    
    private var allEventsList: some View {
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
            viewModel.refreshEvents()
        }
    }
    
    private var sharesList: some View {
        List(viewModel.shares, id: \.self) { share in
            ShareItemView(
                shareModel: share,
                didTapUser: {
                    viewModel.didTapShareUser(shareModel: share)
                },
                didTapEvent: {
                    viewModel.didTapShareEvent(shareModel: share)
                }
            )
            .listRowSeparator(.hidden)
            .listRowBackground(CustColor.backgroundColor)
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .background(CustColor.backgroundColor)
        .refreshable {
            viewModel.refreshShares()
        }
    }
}

struct EventsPage_Previews: PreviewProvider {
    static var previews: some View {
        EventsPage(viewModel: EventsViewModel(
            apiManager: EventsApiManager(
                webService: WebService(
                    keychainManager: KeychainManager()
                )
            )
        ))
    }
}
