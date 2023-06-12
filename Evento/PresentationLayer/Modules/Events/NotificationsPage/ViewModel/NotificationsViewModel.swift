//
//  NotificationsViewModel.swift
//  Evento
//
//  Created by Ramir Amrayev on 13.06.2023.
//

import Foundation
import Combine

final class NotificationsViewModel: ObservableObject {
    // MARK: - Published parameters
    @Published var notifications: [NotificationItemModel] = []
    
    // MARK: - Private parameters
    private let apiManager: EventsApiManagerProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(apiManager: EventsApiManagerProtocol) {
        self.apiManager = apiManager
        
        getNotifications()
    }
    
    func refresh() {
        getNotifications()
    }
    
    private func getNotifications() {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.apiManager.getNotifications().sink(
            receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print(error)
                }
            },
            receiveValue: { [weak self] response in
                self?.notifications = response
            }).store(in: &self.cancellables)
        }
    }
}
