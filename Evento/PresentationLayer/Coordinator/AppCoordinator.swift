//
//  AppCoordinator.swift
//  Evento
//
//  Created by Ramir Amrayev on 16.04.2023.
//

import UIKit

final class AppCoordinator {
    var navigationController: UINavigationController
    var onboardingCoordinator: OnboardingCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showAuthorizationPage()
    }
    
    private func showAuthorizationPage() {
        onboardingCoordinator = OnboardingCoordinator(router: MainRouter(), navigationController: navigationController)
        onboardingCoordinator?.start()
    }
}
