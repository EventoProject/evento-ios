//
//  ChatModuleCoordinator.swift
//  Evento
//
//  Created by Ramir Amrayev on 01.05.2023.
//

import UIKit
import SwiftUI

final class ChatModuleCoordinator: BaseCoordinator {
    init(injection: CustInjection, router: Router, navigationController: UINavigationController) {
        super.init(injection: injection, router: router)
        router.set(navigationController: navigationController)
    }
    
    func start() {
        showChatsPage()
    }
}

private extension ChatModuleCoordinator {
    func showChatsPage() {
        let viewModel = ChatsViewModel(apiManager: injection.inject(ChatApiManagerProtocol.self))
        
        viewModel.showChatPage = { [weak self] chat in
            self?.showChatPage(chatId: chat.id, otherUserName: chat.userName)
        }
        
        let page = UIHostingController(rootView: ChatsPage(viewModel: viewModel))
        page.title = "Chats"
        router.set(viewControllers: [page], animated: true)
    }
    
    func showChatPage(chatId: String, otherUserName: String) {
        let viewModel = ChatViewModel(
            chatId: chatId,
            apiManager: injection.inject(ChatApiManagerProtocol.self),
            keychainManager:  injection.inject(KeychainManagerProtocol.self),
            websocketManager: injection.inject(WebSocketManagerProtocol.self)
        )
        let page = UIHostingController(rootView: ChatPage(viewModel: viewModel))
        page.title = otherUserName
        router.push(viewController: page, animated: true)
    }
}
