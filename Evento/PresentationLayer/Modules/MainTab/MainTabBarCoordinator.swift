//
//  MainTabBarCoordinator.swift
//  Evento
//
//  Created by Ramir Amrayev on 01.05.2023.
//

import UIKit

final class MainTabBarCoordinator: BaseCoordinator {
    init(injection: CustInjection, router: Router, navigationController: UINavigationController) {
        super.init(injection: injection, router: router)
        router.set(navigationController: navigationController)
    }
    
    func start() {
        showMainTabPage()
    }
}

private extension MainTabBarCoordinator {
    func showMainTabPage() {
        let page = MainTabBarController(injection: injection)
        router.set(viewControllers: [page], animated: true)
    }
}
