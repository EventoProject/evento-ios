//
//  AppCoordinator.swift
//  Evento
//
//  Created by Ramir Amrayev on 16.04.2023.
//

import UIKit

final class AppCoordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showAuthorizationPage()
    }
    
    private func showAuthorizationPage() {
        let onboardingCoordinator = OnboardingCoordinator(router: MainRouter(), navigationController: navigationController)
        onboardingCoordinator.start()
    }
}
