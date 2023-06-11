//
//  ChatViewModel.swift
//  Evento
//
//  Created by Ramir Amrayev on 10.06.2023.
//

import Foundation
import Combine

final class ChatViewModel: ObservableObject {
    // MARK: - Published parameters
    @Published var messages: [MessageModel] = []
    @Published var messageInputModel = InputViewModel()
    
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
    var otherUserImageUrl: String?
    var userImageUrl: String?
    
    // MARK: - Private parameters
    private let chatId: String
    private let apiManager: ChatApiManagerProtocol
    private let keychainManager: KeychainManagerProtocol
    private var webSocketManager: WebSocketManagerProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(
        chatId: String,
        apiManager: ChatApiManagerProtocol,
        keychainManager: KeychainManagerProtocol,
        websocketManager: WebSocketManagerProtocol
    ) {
        self.chatId = chatId
        self.apiManager = apiManager
        self.keychainManager = keychainManager
        self.webSocketManager = websocketManager
    }
    
    func onAppear() {
        getChatHistory()
        getChatDetails()
        connectToWebSocket()
    }
    
    func onDisappear() {
        disconnectFromWebSocket()
    }
    
    func didTapSendMessage() {
        let messageText = messageInputModel.text
        DispatchQueue.global().async { [weak self] in
            self?.webSocketManager.sendMessage(messageText)
        }
        messageInputModel.text = ""
    }
}

private extension ChatViewModel {
    func getChatHistory() {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.apiManager.getChatHistory(chatId: self.chatId).sink(
                receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        print(error)
                    }
                },
                receiveValue: { [weak self] model in
                    self?.messages = model
                }
            ).store(in: &self.cancellables)
        }
    }
    
    func getChatDetails() {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.apiManager.getChatDetails(chatId: self.chatId).sink(
                receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        print(error)
                    }
                }, receiveValue: { [weak self] response in
                    self?.handleChatDetailsResponse(response)
                }
            ).store(in: &self.cancellables)
        }
    }
    
    func handleChatDetailsResponse(_ response: ChatDetailsResponseModel) {
        if response.firstUserId == userId {
            userImageUrl = response.firstUserImageLink
            otherUserImageUrl = response.secondUserImageLink
        } else {
            userImageUrl = response.secondUserImageLink
            otherUserImageUrl = response.firstUserImageLink
        }
    }
    
    func connectToWebSocket() {
        guard
            let userIdString = keychainManager.getString(type: .userId),
            let userId = Int(userIdString),
            let username = keychainManager.getString(type: .username)
        else { return }
        
        webSocketManager.onMessageReceived = { [weak self] message in
            if message.type == 1 {
                self?.messages.append(message)
            }
        }
        
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.webSocketManager.connect(chatId: self.chatId, userId: userId, username: username)
        }
    }
    
    func disconnectFromWebSocket() {
        DispatchQueue.global().async { [weak self] in
            self?.webSocketManager.disconnect()
        }
    }
}
