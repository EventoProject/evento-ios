//
//  LikedEventsViewModel.swift
//  Evento
//
//  Created by Ramir Amrayev on 07.06.2023.
//

import SwiftUI
import Combine

final class LikedEventsViewModel: ObservableObject {
    // MARK: - Published parameters
    @Published var events: [EventItemModel] = []
    
    // MARK: - Callbacks
    var showEventDetailPage: Callback<Int>?
    
    // MARK: - Private parameters
    private let apiManager: EventsApiManagerProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(apiManager: EventsApiManagerProtocol) {
        self.apiManager = apiManager
        getLikedEvents()
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
    
    func refresh() {
        getLikedEvents()
    }
    
    private func getLikedEvents() {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.apiManager.getLikedEvents().sink(
                receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        print(error)
                    }
                },
                receiveValue: { [weak self] response in
                    self?.events = response
                }
            ).store(in: &self.cancellables)
        }
    }
}
