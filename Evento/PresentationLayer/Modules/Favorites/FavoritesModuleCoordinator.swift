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
        
        viewModel.showEventDetailPage = { [weak self] eventId in
            self?.showEventPage(eventId: eventId)
        }
        
        let page = UIHostingController(rootView: LikedEventsPage(viewModel: viewModel))
        page.title = "Liked"
        router.set(viewControllers: [page], animated: true)
    }
    
    func showEventPage(eventId: Int) {
        let coordinator = EventCoordinator(eventId: eventId, injection: injection, router: router)
        coordinator.onFinish = { [weak self, weak coordinator] in
            self?.remove(coordinator)
            self?.onFinish?()
        }
        add(coordinator)
        coordinator.start()
    }
}
