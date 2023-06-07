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
    
    // MARK: - Callbacks
    var showEventDetailPage: Callback<EventItemModel>?
    var didTapFilter: VoidCallback?
    
    // MARK: - Private parameters
    private let apiManager: EventsApiManagerProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(apiManager: EventsApiManagerProtocol) {
        self.apiManager = apiManager
        getEvents()
    }
    
    func didTapLike(event: EventItemModel, isLiked: Bool) {
        guard let eventIndex = events.firstIndex(of: event) else { return }
        events[eventIndex].isLiked = isLiked
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
        showEventDetailPage?(event)
    }
    
    func refresh() {
        getEvents()
    }
    
    private func getEvents() {
        DispatchQueue.global().async { [weak self] in
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
}
