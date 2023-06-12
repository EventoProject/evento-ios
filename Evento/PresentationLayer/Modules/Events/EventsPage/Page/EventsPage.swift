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

struct ShareItemView: View {
    let shareModel: ShareItemModel
    let didTapUser: VoidCallback
    let didTapEvent: VoidCallback
    
    private var eventCostText: String {
        if shareModel.cost == "Free" {
            return "Free"
        } else {
            return "\(shareModel.cost) tg"
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            userHeader
            CustText(
                text: shareModel.shareDescription,
                weight: .regular,
                size: 16
            )
            HStack(spacing: 15) {
                lightGrayLineView
                eventView
            }
        }
    }
    
    private var userHeader: some View {
        HStack {
            userAvatarNameView
            Spacer()
            CustText(text: "30 min ago", weight: .regular, size: 14)
                .foregroundColor(CustColor.lightGray)
        }
    }
    
    private var userAvatarNameView: some View {
        Button(
            action: didTapUser,
            label: {
                HStack {
                    AsyncAvatarImage(
                        url: shareModel.userImageLink,
                        size: 47
                    )
                    NameUsernameView(name: shareModel.userName, username: shareModel.username)
                }
            }
        )
    }
    
    private var lightGrayLineView: some View {
        VStack {
            Spacer()
        }
        .frame(width: 1)
        .background(CustColor.lightGray)
    }
    
    private var eventView: some View {
        Button(
            action: didTapEvent,
            label: {
                VStack(alignment: .leading) {
                    EventItemImage(imageUrl: shareModel.imageLink)
                        .padding(.bottom, 10)
                    CustText(text: shareModel.name, weight: .regular, size: 16)
                    CustText(
                        text: "\(shareModel.format) - \(eventCostText) - \(shareModel.date)",
                        weight: .regular,
                        size: 14
                    )
                    .foregroundColor(CustColor.lightGray)
                    .padding(.bottom, 8)
                    CustText(text:  shareModel.description, weight: .regular, size: 14)
                        .lineLimit(2)
                }
            }
        )
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
