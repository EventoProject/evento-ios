//
//  LikesViewModel.swift
//  Evento
//
//  Created by Ramir Amrayev on 30.05.2023.
//

import SwiftUI
import Combine

final class LikesViewModel: ObservableObject {
    // MARK: - Published parameters
    @Published var likes: [LikeItemModel] = []
    
    // MARK: - Public parameters
    lazy var userId: Int? = {
        if
            let userIdString = keychainManager.getString(type: .userId),
            let userId = Int(userIdString) {
            return userId
        } else {
            return nil
        }
    }()
    
    // MARK: - Private parameters
    private let eventId: Int
    private let apiManager: EventsApiManagerProtocol
    private let keychainManager: KeychainManagerProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(eventId: Int, apiManager: EventsApiManagerProtocol, keychainManager: KeychainManagerProtocol) {
        self.eventId = eventId
        self.apiManager = apiManager
        self.keychainManager = keychainManager
        
        getLikes()
    }
    
    func didTapFollow(like: LikeItemModel, follow: Bool) {
        print("Did tap \(follow ? "follow" : "unfollow") \(like.name)")
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.apiManager.follow(isFollow: follow, userId: like.id).sink(
                receiveCompletion: { [weak self] completion in
                    if case let .failure(error) = completion {
                        print(error)
                        self?.getLikes()
                    }
                },
                receiveValue: { _ in
                    print("Success")
                }
            ).store(in: &self.cancellables)
        }
    }
    
    private func getLikes() {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.apiManager.getLikes(eventId: self.eventId).sink(
                receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        print(error)
                    }
                },
                receiveValue: { [weak self] response in
                    self?.likes = response
                }
            ).store(in: &self.cancellables)
        }
    }
}
