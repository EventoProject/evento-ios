//
//  EventsModuleCoordinator.swift
//  Evento
//
//  Created by Ramir Amrayev on 01.05.2023.
//

import UIKit
import SwiftUI

final class EventsModuleCoordinator: BaseCoordinator {
    var onFinish: VoidCallback?
    
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
        viewModel.didTapFilter = { [weak self] in
            self?.showFilterPage()
        }
        
        let page = EventsHostingController(viewModel: viewModel)
        router.set(viewControllers: [page], animated: true)
    }
    
    func showEventPage(_ event: EventItemModel) {
        let coordinator = EventCoordinator(event: event, injection: injection, router: router)
        coordinator.onFinish = { [weak self, weak coordinator] in
            self?.remove(coordinator)
            self?.onFinish?()
        }
        add(coordinator)
        coordinator.start()
    }
    
    func showFilterPage() {
        let viewModel = FilterViewModel(apiManager: injection.inject(AddApiManagerProtocol.self))
        let page = FilterHostingController(viewModel: viewModel)
        router.push(viewController: page, animated: true)
    }
}
