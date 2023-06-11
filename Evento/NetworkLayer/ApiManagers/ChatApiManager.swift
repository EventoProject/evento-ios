//
//  ChatApiManager.swift
//  Evento
//
//  Created by Ramir Amrayev on 10.06.2023.
//

import Foundation
import Combine

protocol ChatApiManagerProtocol {
    func getChats() -> AnyPublisher<[ChatsResponseItemModel], NetworkError>
    func getChatHistory(chatId: String) -> AnyPublisher<[MessageModel], NetworkError>
    func getChatDetails(chatId: String) -> AnyPublisher<ChatDetailsResponseModel, NetworkError>
}

final class ChatApiManager: ChatApiManagerProtocol {
    private let webService: WebServiceProtocol
    
    init(webService: WebServiceProtocol) {
        self.webService = webService
    }
    
    func getChats() -> AnyPublisher<[ChatsResponseItemModel], NetworkError> {
        webService.request(ChatTarget.chats)
    }
    
    func getChatHistory(chatId: String) -> AnyPublisher<[MessageModel], NetworkError> {
        webService.request(ChatTarget.chatHistory(chatId: chatId))
    }
    
    func getChatDetails(chatId: String) -> AnyPublisher<ChatDetailsResponseModel, NetworkError> {
        webService.request(ChatTarget.chatDetails(chatId: chatId))
    }
}
