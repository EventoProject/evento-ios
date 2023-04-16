//
//  OnboardingCoordinator.swift
//  Evento
//
//  Created by Ramir Amrayev on 16.04.2023.
//

import UIKit
import SwiftUI

final class OnboardingCoordinator: BaseCoordinator {
    private let navigationController: UINavigationController
    
    init(router: Router, navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init(router: router)
        
        router.set(navigationController: navigationController)
    }
    
    func start() {
        showAuthorizationPage()
    }
}

private extension OnboardingCoordinator {
    func showAuthorizationPage() {
        // Need to replace with Authorization page
        let viewModel = NewsPageViewModel(apiManager: NewsApiManager())
        let page = UIHostingController(rootView: NewsPage(viewModel: viewModel))
        router.set(viewControllers: [page], animated: false)
    }
}
