//
//  UserProfileViewModel.swift
//  Evento
//
//  Created by RAmrayev on 11.06.2023.
//

import Foundation
import SwiftUI
import Combine

struct CreateRoomModel{
    let roomID: String
    let username: String
}


final class UserProfileViewModel: ObservableObject{
    
    private let id: Int
    var myID: Int = 0
    private let apiManager: ProfileApiManagerProtocol
    private let eventApiManager: EventsApiManagerProtocol
    private let chatApiManager: ChatApiManagerProtocol
    var showEventDetailPage: Callback<Int>?
    @Published var shares: [ShareItemModel] = []
    @Published var user : ProfileModel?
    private var cancellables = Set<AnyCancellable>()
    var showChatPage: Callback<CreateRoomModel>?
    @Published var isLoadingButton = false

    
    init(apiManager: ProfileApiManagerProtocol, eventApiManager: EventsApiManagerProtocol, chatApiManager: ChatApiManagerProtocol, id: Int){
        self.apiManager = apiManager
        self.id = id
        self.chatApiManager = chatApiManager
        self.eventApiManager = eventApiManager
        getSharedEvents()
        getProfile()
    }
    
    func createRoom(){
        DispatchQueue.global().async {
            [weak self] in
            guard let self = self, let user = self.user else {return}
            self.chatApiManager.createRoom(userID: self.id).sink(receiveCompletion: {
                completion in
                if case let .failure(error) = completion{
                    print(error)
                }
                self.isLoadingButton = false
            }, receiveValue: {[weak self] model in
                let roomModel = CreateRoomModel(roomID: model.chatRoomId, username: user.name)
                self?.showChatPage?(roomModel)
            }).store(in: &self.cancellables)
        }
    }
    
    func restoreRoom(id: String){
        DispatchQueue.global().async { [weak self] in
            guard let self = self, let user = self.user else {return}
            self.chatApiManager.restoreRoom(userID: self.id).sink(receiveCompletion: {
                completion in
                if case let .failure(error) = completion{
                    print(error)
                }
                self.isLoadingButton = false
            }, receiveValue: {[weak self] model in
                let roomModel = CreateRoomModel(roomID: id, username: user.name)
                self?.showChatPage?(roomModel)
            }).store(in: &self.cancellables)
        }
    }
    
    func joinRoom(id: String){
        self.isLoadingButton = false
        guard let user = self.user else {return}
        let roomModel = CreateRoomModel(roomID: id, username: (user.name))
        showChatPage?(roomModel)
    }
    
    func checkChatRoomExists(){
        isLoadingButton = true
        print("here")
        DispatchQueue.global().async { [weak self] in
            guard let self = self else {
                return
            }
            self.chatApiManager.checkChatRoomExists(userID: self.id).sink(receiveCompletion: {
                completion in
                
                if case let .failure(error) = completion{
                    print(error)
                }
            }, receiveValue: {[weak self] model in
                if model.existsInDb {
                    if model.existsInWs {
                        self?.joinRoom(id: model.chatRoomId)
                    } else {
                        self?.restoreRoom(id: model.chatRoomId)
                    }
                } else {
                    self?.createRoom()
                }
            }).store(in: &self.cancellables)
        }
    }
    
    func getProfile() {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.apiManager.getProfile(id: self.id).sink(
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
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.apiManager.getMyProfile().sink(
                receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        print("something wrong \(error)")
                    }
                },
                receiveValue: { [weak self] model in
                    self?.myID = model.id
                }
            ).store(in: &self.cancellables)
        }
    }
    
    func didTapFollow() {
        
        DispatchQueue.global().async { [weak self] in
            guard let self = self, let user = self.user else { return }
            self.eventApiManager.follow(isFollow: !user.following, userId: self.id).sink(
                receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        print(error)
                    }
                },
                receiveValue: { _ in
                    self.getProfile()
                    print("Success")
                }
            ).store(in: &self.cancellables)
        }
        self.getProfile()
    }
    
    private func getSharedEvents() {
        // TODO: return to async
        DispatchQueue.global().sync { [weak self] in
            guard let self = self else { return }
            self.apiManager.getUserSharedEvents(userID: self.id).sink(
                receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        print(error)
                    }
                },
                receiveValue: { [weak self] model in
                    self?.shares = model
                }
            ).store(in: &self.cancellables)
        }
    }
    
    func didTapShareEvent(shareModel: ShareItemModel) {
        showEventDetailPage?(shareModel.id)
    }
}
