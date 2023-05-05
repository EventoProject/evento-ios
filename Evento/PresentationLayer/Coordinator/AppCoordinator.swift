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
    
    init(navigationController: UINavigationController, injection: CustInjection) {
        self.navigationController = navigationController
        self.injection = injection
    }
    
    func start() {
        showAuthorizationPage()
    }
    
    private func showAuthorizationPage() {
        onboardingCoordinator = OnboardingCoordinator(
            injection: injection,
            router: MainRouter(),
            navigationController: navigationController
        )
        onboardingCoordinator?.start()
    }
}
