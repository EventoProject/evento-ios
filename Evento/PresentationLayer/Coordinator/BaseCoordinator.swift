//
//  BaseCoordinator.swift
//  Evento
//
//  Created by Ramir Amrayev on 16.04.2023.
//

import Foundation

class BaseCoordinator {
    let injection: CustInjection
    let router: Router
    private var childCoordinators: [BaseCoordinator] = []

    init(injection: CustInjection, router: Router) {
        self.injection = injection
        self.router = router
    }

    func add(_ coordinator: BaseCoordinator) {
        guard !childCoordinators.contains(where: { $0 === coordinator }) else {
            return
        }

        childCoordinators.append(coordinator)
    }

    func remove(_ coordinator: BaseCoordinator?) {
        guard let coordinator = coordinator, !childCoordinators.isEmpty else { return }

        // Recursively clear child-coordinators
        if !coordinator.childCoordinators.isEmpty {
            coordinator.childCoordinators
                .filter { $0 !== coordinator }
                .forEach { coordinator.remove($0) }
        }

        for (index, element) in childCoordinators.enumerated() where element === coordinator {
            childCoordinators.remove(at: index)
            break
        }
    }
}
