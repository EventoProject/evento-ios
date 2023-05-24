//
//  EventsModuleCoordinator.swift
//  Evento
//
//  Created by Ramir Amrayev on 01.05.2023.
//

import UIKit
import SwiftUI

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
        let viewModel = EventsViewModel(apiManager: injection.inject(EventsApiManagerProtocol.self))
        
        viewModel.showEventDetailPage = { [weak self] event in
            self?.showEventPage(event)
        }
        
        let page = EventsHostingController(rootView: EventsPage(viewModel: viewModel))
        router.set(viewControllers: [page], animated: true)
    }
    
    func showEventPage(_ event: EventItemModel) {
        let viewModel = EventViewModel(event: event)
        let page = UIHostingController(rootView: EventPage(viewModel: viewModel))
        router.push(viewController: page, animated: true)
    }
}
