//
//  AppCoordinator.swift
//  Evento
//
//  Created by Ramir Amrayev on 16.04.2023.
//

import UIKit

final class AppCoordinator {
    var navigationController: UINavigationController
    private let injection: CustInjection
    private var onboardingCoordinator: OnboardingCoordinator?
    private var mainTabBarCoordinator: MainTabBarCoordinator?
    
    init(navigationController: UINavigationController, injection: CustInjection) {
        self.navigationController = navigationController
        self.injection = injection
    }
    
    func start() {
        let keychainManager = injection.inject(KeychainManagerProtocol.self)
        let accessToken = keychainManager.getString(type: .accessToken) ?? ""
        if accessToken.isEmpty {
            showAuthorizationPage()
        } else {
            showMainTabBarPage()
        }
    }
    
    func reauthorize() {
        navigationController.setNavigationBarHidden(false, animated: false)
        showAuthorizationPage()
//        navigationController.showAlert(message: "Your session has expired please relogin")
    }
}

private extension AppCoordinator {
    func showAuthorizationPage() {
        onboardingCoordinator = OnboardingCoordinator(
            injection: injection,
            router: MainRouter(),
            navigationController: navigationController
        )
        onboardingCoordinator?.start()
    }
    
    func showMainTabBarPage() {
        navigationController.setNavigationBarHidden(true, animated: false)
        
        mainTabBarCoordinator = MainTabBarCoordinator(
            injection: injection,
            router: MainRouter(),
            navigationController: navigationController
        )
        mainTabBarCoordinator?.start()
    }
}
