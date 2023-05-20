//
//  EventsModuleCoordinator.swift
//  Evento
//
//  Created by Ramir Amrayev on 01.05.2023.
//

import UIKit

final class EventsModuleCoordinator: BaseCoordinator {
    init(injection: CustInjection, router: Router, navigationController: UINavigationController) {
        super.init(injection: injection, router: router)
        router.set(navigationController: navigationController)
    }
    
    func start() {
        showEventsPage()
    }
}

private extension EventsModuleCoordinator {
    func showEventsPage() {
        let page = EventsHostingController(rootView: EventsPage(viewModel: EventsViewModel()))
        router.set(viewControllers: [page], animated: true)
    }
}
