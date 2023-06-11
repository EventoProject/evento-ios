//
//  UserProfileViewModel.swift
//  Evento
//
//  Created by RAmrayev on 11.06.2023.
//

import Foundation
import SwiftUI
import Combine

final class UserProfileViewModel: ObservableObject{
    
    let id: Int?
    private let apiManager: ProfileApiManagerProtocol
    private let eventApiManager: EventsApiManagerProtocol
    @Published var user : ProfileModel?
    @Published var events: [EventItemModel] = []
    private var cancellables = Set<AnyCancellable>()
    
    
    init(apiManager: ProfileApiManagerProtocol, eventApiManager: EventsApiManagerProtocol, id: Int){
        self.apiManager = apiManager
        self.id = id
        self.eventApiManager = eventApiManager
        self.getEvents()
        self.getProfile()
        
    }

    func getProfile() {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.apiManager.getProfile(id: self.id!).sink(
                receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        print("something wrong \(error)")
                    }
                },
                receiveValue: { [weak self] model in
                    self?.user = model
            
                }
            ).store(in: &self.cancellables)
        }
    }
    
    
    
    func didTapFollow() {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.eventApiManager.follow(isFollow: !(self.user!.following), userId: self.id!).sink(
                receiveCompletion: { [weak self] completion in
                    if case let .failure(error) = completion {
                        print(error)
                    }
                },
                receiveValue: { _ in
                    print("Success")
                }
            ).store(in: &self.cancellables)
        }
        self.getProfile()
    }
    
    
    
    //
    private func getEvents() {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
//            self.eventApiManager.getMyEvents().sink(
            self.eventApiManager.getEvents().sink(
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
