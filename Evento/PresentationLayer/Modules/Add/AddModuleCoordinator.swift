//
//  AddModuleCoordinator.swift
//  Evento
//
//  Created by Ramir Amrayev on 01.05.2023.
//

import UIKit

final class AddModuleCoordinator: BaseCoordinator {
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
        
    }
}
