//
//  AddModuleCoordinator.swift
//  Evento
//
//  Created by Ramir Amrayev on 01.05.2023.
//

import UIKit

final class AddModuleCoordinator: BaseCoordinator {
    // MARK: - Callbacks
    var openEventsModule: VoidCallback?
    
    init(injection: CustInjection, router: Router, navigationController: UINavigationController) {
        super.init(injection: injection, router: router)
        router.set(navigationController: navigationController)
    }
    
    func start() {
        showAddPage()
    }
}

private extension AddModuleCoordinator {
    func showAddPage() {
        let page = AddContainerPage(injection: injection)
        page.openEventsModule = openEventsModule
        router.set(viewControllers: [page], animated: true)
    }
}
