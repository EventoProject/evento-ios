//
//  EventCoordinator.swift
//  Evento
//
//  Created by Ramir Amrayev on 05.06.2023.
//

import SwiftUI

final class EventCoordinator: BaseCoordinator {
    var onFinish: VoidCallback?
    
    private let eventId: Int
    
    init(eventId: Int, injection: CustInjection, router: Router) {
        self.eventId = eventId
        super.init(injection: injection, router: router)
    }
    
    func start() {
        showEventPage(eventId: eventId)
    }
}

private extension EventCoordinator {
    func showEventPage(eventId: Int) {
        let viewModel = EventViewModel(
            eventId: eventId,
            apiManager: injection.inject(EventsApiManagerProtocol.self)
        )
        
        viewModel.showLikesPage = { [weak self] in
            self?.showLikesPage(eventId: eventId)
        }
        viewModel.showCommentsPage = { [weak self] in
            self?.showCommentsPage(eventId: eventId)
        }
        viewModel.showWebPage = { [weak self] args in
            self?.showWebPage(url: args.url, title: args.title)
        }
        
        let page = UIHostingController(rootView: EventPage(viewModel: viewModel))
        page.title = "Event"
        router.push(viewController: page, animated: true)
    }
    
    func showLikesPage(eventId: Int) {
        let viewModel = LikesViewModel(
            eventId: eventId,
            apiManager: injection.inject(EventsApiManagerProtocol.self),
            keychainManager: injection.inject(KeychainManagerProtocol.self)
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
    
    func showWebPage(url: String, title: String) {
        guard let url = URL(string: url) else { return }
        let page = UIHostingController(rootView: WebViewPage(url: url))
        page.title = title
        router.push(viewController: page, animated: true)
    }
}
