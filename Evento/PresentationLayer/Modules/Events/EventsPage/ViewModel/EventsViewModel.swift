//
//  EventsViewModel.swift
//  Evento
//
//  Created by Ramir Amrayev on 23.05.2023.
//

import SwiftUI
import Combine

final class EventsViewModel: ObservableObject {
    // MARK: - Published parameters
    @Published var events: [EventItemModel] = []
    @Published var selectedSegmentedControlItem = "All events"
    @Published var shares: [ShareItemModel] = []
    
    // MARK: - Callbacks
    var showEventDetailPage: Callback<Int>?
    var showUserDetailPage: Callback<Int>?
    var didTapFilter: VoidCallback?
    var didTapNotifications: VoidCallback?
    
    // MARK: - Public parameters
    let segmentedControlItems = ["All events", "Shares"]
    
    // MARK: - Private parameters
    private let apiManager: EventsApiManagerProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(apiManager: EventsApiManagerProtocol) {
        self.apiManager = apiManager
        
        getEvents()
        getSharedEvents()
    }
    
    func didTapLike(event: EventItemModel, isLiked: Bool) {
        guard let eventIndex = events.firstIndex(of: event) else { return }
        events[eventIndex].liked = isLiked
        let eventId = event.id
        
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.apiManager.like(isLike: isLiked, eventId: eventId).sink(
                receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        print(error)
                    }
                }, receiveValue: { _ in
                    print("Successfully \(isLiked ? "liked" : "disliked")")
                }
            ).store(in: &self.cancellables)
        }
    }
    
    func didTap(event: EventItemModel) {
        showEventDetailPage?(event.id)
    }
    
    func didTapOrganizer(event: EventItemModel) {
        print("Show organizer \(event.userName) profile page")
    }
    
    func refreshEvents() {
        getEvents()
    }
    
    func refreshShares() {
        getSharedEvents()
    }
    
    func didTapShareUser(shareModel: ShareItemModel) {
        showUserDetailPage?(shareModel.userId)
    }
    
    func didTapShareEvent(shareModel: ShareItemModel) {
        showEventDetailPage?(shareModel.id)
    }
}

private extension EventsViewModel {
    func getEvents() {
        // TODO: Change to async
        DispatchQueue.global().sync { [weak self] in
            guard let self = self else { return }
            self.apiManager.getEvents().sink(
                receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        print(error)
                    }
                },
                receiveValue: { [weak self] model in
                    self?.events = model.events
                }
            ).store(in: &self.cancellables)
        }
    }
    
    func getSharedEvents() {
        // TODO: Change to async
        DispatchQueue.global().sync { [weak self] in
            guard let self = self else { return }
            self.apiManager.getSharedEvents().sink(
                receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        print(error)
                    }
                },
                receiveValue: { [weak self] response in
                    self?.shares = response
                }
            ).store(in: &self.cancellables)
        }
    }
}
