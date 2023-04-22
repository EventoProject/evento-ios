//
//  OnboardingCoordinator.swift
//  Evento
//
//  Created by Ramir Amrayev on 16.04.2023.
//

import UIKit
import SwiftUI

final class OnboardingCoordinator: BaseCoordinator {
    private let navigationController: UINavigationController
    
    init(router: Router, navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init(router: router)
        
        router.set(navigationController: navigationController)
    }
    
    func start() {
        showAuthorizationPage()
    }
}

private extension OnboardingCoordinator {
    func showAuthorizationPage() {
        // Need to replace with Authorization page
//        let viewModel = NewsPageViewModel(apiManager: NewsApiManager())
//
//        viewModel.showArticle = { [weak self] article in
//            guard let self = self else { return }
//            self.showArticlePage(article: article)
//        }
//
//        let page = UIHostingController(rootView: NewsPage(viewModel: viewModel))
        let viewModel = SignInViewModel()
        let page = UIHostingController(rootView: SignInPage(viewModel: viewModel))
        router.set(viewControllers: [page], animated: false)
    }
    
    func showArticlePage(article: Article) {
        let page = UIHostingController(rootView: ArticlePage(article: article))
        router.push(viewController: page, animated: true)
    }
}
