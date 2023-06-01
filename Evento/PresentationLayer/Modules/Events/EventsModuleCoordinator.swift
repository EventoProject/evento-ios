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
        viewModel.didTapFilter = { [weak self] in
            self?.showFilterPage()
        }
        
        let page = EventsHostingController(viewModel: viewModel)
        router.set(viewControllers: [page], animated: true)
    }
    
    func showEventPage(_ event: EventItemModel) {
        let viewModel = EventViewModel(
            event: event,
            apiManager: injection.inject(EventsApiManagerProtocol.self)
        )
        
        viewModel.showLikesPage = { [weak self] in
            self?.showLikesPage(eventId: event.id)
        }
        viewModel.showCommentsPage = { [weak self] in
            self?.showCommentsPage(eventId: event.id)
        }
        
        let page = UIHostingController(rootView: EventPage(viewModel: viewModel))
        page.title = "Event"
        router.push(viewController: page, animated: true)
    }
    
    func showFilterPage() {
        let viewModel = FilterViewModel(apiManager: injection.inject(AddApiManagerProtocol.self))
        let page = FilterHostingController(viewModel: viewModel)
        router.push(viewController: page, animated: true)
    }
    
    func showLikesPage(eventId: Int) {
        let viewModel = LikesViewModel(
            eventId: eventId,
            apiManager: injection.inject(EventsApiManagerProtocol.self)
        )
        let page = UIHostingController(rootView: LikesPage(viewModel: viewModel))
        page.title = "Likes"
        router.push(viewController: page, animated: true)
    }
    
    func showCommentsPage(eventId: Int) {
        let viewModel = CommentsViewModel(
            eventId: eventId,
            apiManager: injection.inject(EventsApiManagerProtocol.self),
            keychainManager: injection.inject(KeychainManagerProtocol.self)
        )
        let page = UIHostingController(rootView: CommentsPage(viewModel: viewModel))
        page.title = "Comments"
        router.push(viewController: page, animated: true)
    }
}
