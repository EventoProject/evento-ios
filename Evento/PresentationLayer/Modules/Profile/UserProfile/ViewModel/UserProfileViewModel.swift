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
    init(roomID: String, username: String) {
        self.roomID = roomID
        self.username = username
    }
}


final class UserProfileViewModel: ObservableObject{
    
    let id: Int?
    var myID: Int = 0
    private let apiManager: ProfileApiManagerProtocol
    private let eventApiManager: EventsApiManagerProtocol
    private let chatApiManager: ChatApiManagerProtocol

    @Published var user : ProfileModel?
    @Published var events: [EventItemModel] = []
    private var cancellables = Set<AnyCancellable>()
    var showChatPage: Callback<CreateRoomModel>?
    @Published var isLoadingButton = false

    
    init(apiManager: ProfileApiManagerProtocol, eventApiManager: EventsApiManagerProtocol, chatApiManager: ChatApiManagerProtocol, id: Int){
        self.apiManager = apiManager
        self.id = id
        self.chatApiManager = chatApiManager
        self.eventApiManager = eventApiManager
        self.getEvents()
        self.getProfile()
    }
    
    func createRoom(){
        DispatchQueue.global().async {
            [weak self] in
            guard let self = self else {return}
            self.chatApiManager.createRoom(userID: self.id!).sink(receiveCompletion: {
                completion in
                if case let .failure(error) = completion{
                    print(error)
                }
                self.isLoadingButton = false
            }, receiveValue: {[weak self] model in
                let roomModel = CreateRoomModel(roomID: model.chatRoomId, username: (self?.user!.name)!)
                self?.showChatPage?(roomModel)
            }).store(in: &self.cancellables)
        }
    }
    
    func restoreRoom(id: String){
        DispatchQueue.global().async { [weak self] in
            guard let self = self else {return}
            self.chatApiManager.restoreRoom(userID: self.id!).sink(receiveCompletion: {
                completion in
                if case let .failure(error) = completion{
                    print(error)
                }
                self.isLoadingButton = false
            }, receiveValue: {[weak self] model in
                let roomModel = CreateRoomModel(roomID: id, username: (self?.user!.name)!)
                self?.showChatPage?(roomModel)
            }).store(in: &self.cancellables)
        }
    }
    
    func joinRoom(id: String){
        self.isLoadingButton = false
        let roomModel = CreateRoomModel(roomID: id, username: (user!.name))
        showChatPage?(roomModel)
    }
    
    func checkChatRoomExists(){
        isLoadingButton = true
        print("here")
        DispatchQueue.global().async { [weak self] in
            guard let self = self else {
                return
            }
            self.chatApiManager.checkChatRoomExists(userID: self.id!).sink(receiveCompletion: {
                completion in
                if case let .failure(error) = completion{
                    print(error)
                }
            }, receiveValue: {[weak self] model in
                if model.existsInDb == false && model.existsInWs == false{
                    self?.createRoom()
                }
                else if model.existsInDb == true && model.existsInWs == false{
                    self?.restoreRoom(id: model.chatRoomId)
                }
                else if model.existsInDb == true && model.existsInWs == true{
                    self?.joinRoom(id: model.chatRoomId)
                }
            }).store(in: &self.cancellables)
        }
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
            guard let self = self else { return }
            guard case self.user = self.user else { return }
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
    
    private func getEvents() {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
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
