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
    
    // MARK: - Private parameters
    private let chatId: String
    private let apiManager: ChatApiManagerProtocol
    private let keychainManager: KeychainManagerProtocol
    private let webSocketManager = WebSocketManager()
    private var cancellables = Set<AnyCancellable>()
    
    init(
        chatId: String,
        apiManager: ChatApiManagerProtocol,
        keychainManager: KeychainManagerProtocol
    ) {
        self.chatId = chatId
        self.apiManager = apiManager
        self.keychainManager = keychainManager
        
        getChatHistory()
        connectToWebSocket()
    }
    
    private func getChatHistory() {
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
    
    private func connectToWebSocket() {
        guard
            let userIdString = keychainManager.getString(type: .userId),
            let userId = Int(userIdString),
            let username = keychainManager.getString(type: .username),
            let url = URL(
                string:
                    "ws://localhost:8081/ws/joinRoom/\(chatId)?userId=\(userId)&username=\(username)"
            )
        else { return }
        
        webSocketManager.onMessageReceived = { message in
            print(message.content)
        }
        
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.webSocketManager.connect(to: url)
        }
    }
}
