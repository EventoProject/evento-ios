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
        let profileViewModel = ProfileViewModel(apiManager: injection.inject(ProfileApiManagerProtocol.self),eventApiManager: injection.inject(EventsApiManagerProtocol.self))
        let page = ProfileHostingController(rootView: ProfilePage(profileViewModel: profileViewModel))
        page.didBell = {[weak self] in
            self?.showSettingPage()
        }
        router.set(viewControllers: [page], animated: true)
    }
    func showSettingPage( ) {
        let viewModel = GeneralViemModel()
        let page = UIHostingController(rootView: SettingPage(viewModel: viewModel))

        viewModel.didTapLogOut = { [weak self] in
            self?.logout()
        }
        router.push(viewController: page, animated: true)
    }
}
