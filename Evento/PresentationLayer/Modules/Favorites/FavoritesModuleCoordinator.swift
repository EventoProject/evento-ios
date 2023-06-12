//
//  FavoritesModuleCoordinator.swift
//  Evento
//
//  Created by Ramir Amrayev on 01.05.2023.
//

import UIKit
import SwiftUI

final class FavoritesModuleCoordinator: BaseCoordinator {
    var onFinish: VoidCallback?
    
    init(injection: CustInjection, router: Router, navigationController: UINavigationController) {
        super.init(injection: injection, router: router)
        router.set(navigationController: navigationController)
    }
    
    func start() {
        showFavoritesPage()
    }
}

private extension FavoritesModuleCoordinator {
    func showFavoritesPage() {
        let viewModel = LikedEventsViewModel(apiManager: injection.inject(EventsApiManagerProtocol.self))
        
        viewModel.showEventDetailPage = { [weak self] eventId in
            self?.showEventPage(eventId: eventId)
        }
        
        viewModel.showUserProfilePage = { [weak self] userID in
            self?.showUserProfile(id: userID)
        }
        
        
        let page = UIHostingController(rootView: LikedEventsPage(viewModel: viewModel))
        page.title = "Liked"
        router.set(viewControllers: [page], animated: true)
    }
    func showUserProfile(id: Int){
        let viewModel = UserProfileViewModel(apiManager: injection.inject(ProfileApiManagerProtocol.self),eventApiManager: injection.inject(EventsApiManagerProtocol.self), chatApiManager: injection.inject(ChatApiManagerProtocol.self), id: id)
        viewModel.showChatPage = { [weak self] room in
            self?.showChatPage(chatId: room.roomID, otherUserName: room.username)
        }
        viewModel.showEventDetailPage={[weak self] eventId in
            self?.showEventPage(eventId: eventId)
        }
        let page = UIHostingController(rootView: UserProfilePage(viewModel: viewModel))
        router.push(viewController: page, animated: true)
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
    
    func showEventPage(eventId: Int) {
        let coordinator = EventCoordinator(eventId: eventId, injection: injection, router: router)
        coordinator.onFinish = { [weak self, weak coordinator] in
            self?.remove(coordinator)
            self?.onFinish?()
        }
        add(coordinator)
        coordinator.start()
    }
}
