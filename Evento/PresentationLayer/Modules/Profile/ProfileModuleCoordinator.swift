//
//  ProfileModuleCoordinator.swift
//  Evento
//
//  Created by Ramir Amrayev on 01.05.2023.
//

import SwiftUI
import Foundation

final class ProfileModuleCoordinator: BaseCoordinator {
    init(injection: CustInjection, router: Router, navigationController: UINavigationController) {
        super.init(injection: injection, router: router)
        router.set(navigationController: navigationController)
    }
    
    func start() {
        showProfilePage()
    }
    func logout(){
        Application.shared.reauthorize()
    }
}

private extension ProfileModuleCoordinator {
    func showProfilePage() {
        let profileViewModel = ProfileViewModel(apiManager: injection.inject(ProfileApiManagerProtocol.self))
        let page = ProfileHostingController(rootView: ProfilePage(profileViewModel: profileViewModel))
        page.didBell = {[weak self] in
            self?.showSettingPage()
        }
        profileViewModel.moveToSearchPage = { [weak self] in
            self?.showSearchPage()
        }
        router.set(viewControllers: [page], animated: true)
    }
    func showSettingPage() {
        let viewModel = GeneralViemModel()
        let page = UIHostingController(rootView: SettingPage(viewModel: viewModel))
        
        viewModel.didTapLogOut = { [weak self] in
            self?.logout()
        }
        router.push(viewController: page, animated: true)
    }
    func showSearchPage(){
        let viewModel = SearchViewModel(apiManager: injection.inject(ProfileApiManagerProtocol.self))
        let page = SearchHostingController(viewModel: viewModel)
        viewModel.showUserProfile = { [weak self] id in
            self?.showUserProfile(id: id)
        }
        page.title = "Search"
        router.push(viewController: page, animated: true)
    }
    func showUserProfile(id: Int){
        let viewModel = UserProfileViewModel(apiManager: injection.inject(ProfileApiManagerProtocol.self),eventApiManager: injection.inject(EventsApiManagerProtocol.self), chatApiManager: injection.inject(ChatApiManagerProtocol.self), id: id)
        viewModel.showChatPage = { [weak self] room in
            self?.showChatPage(chatId: room.roomID, otherUserName: room.username)
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
}
