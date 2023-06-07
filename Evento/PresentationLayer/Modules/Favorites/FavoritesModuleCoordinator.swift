//
//  FavoritesModuleCoordinator.swift
//  Evento
//
//  Created by Ramir Amrayev on 01.05.2023.
//

import UIKit
import SwiftUI

final class FavoritesModuleCoordinator: BaseCoordinator {
    var onFinish: VoidCallback?
    
    init(injection: CustInjection, router: Router, navigationController: UINavigationController) {
        super.init(injection: injection, router: router)
        router.set(navigationController: navigationController)
    }
    
    func start() {
        showFavoritesPage()
    }
}

private extension FavoritesModuleCoordinator {
    func showFavoritesPage() {
        let viewModel = LikedEventsViewModel(apiManager: injection.inject(EventsApiManagerProtocol.self))
        
        viewModel.showEventDetailPage = { [weak self] event in
            self?.showEventPage(event)
        }
        
        let page = UIHostingController(rootView: LikedEventsPage(viewModel: viewModel))
        page.title = "Liked"
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
}
