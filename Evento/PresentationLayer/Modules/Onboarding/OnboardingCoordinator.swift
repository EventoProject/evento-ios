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
    
    init(injection: CustInjection, router: Router, navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init(injection: injection, router: router)
        
        router.set(navigationController: navigationController)
    }
    
    func start() {
        showSignInPage()
//        showNewsPage()
    }
}

private extension OnboardingCoordinator {
    func showSignInPage(animated: Bool = false) {
        let viewModel = SignInViewModel(
            apiManager: injection.inject(OnboardingApiManagerProtocol.self),
            webService: injection.inject(WebServiceProtocol.self),
            keychainManager: injection.inject(KeychainManagerProtocol.self)
        )
        
        viewModel.didTapForgotPassword = { [weak self] in
            self?.showForgotPasswordPage()
        }
        
        viewModel.didTapRegister = { [weak self] in
            self?.showRegistrationPage()
        }
        
        viewModel.didTapSignIn = { [weak self] in
            self?.showMainTab()
        }
        
        let page = UIHostingController(rootView: SignInPage(viewModel: viewModel))
        router.set(viewControllers: [page], animated: animated)
    }
    
    func showForgotPasswordPage() {
        let viewModel = ForgotPasswordViewModel()
        
        viewModel.resetPassword = { [weak self] in
            self?.showPasswordResetPage()
        }
        
        let page = UIHostingController(rootView: ForgotPasswordPage(viewModel: viewModel))
        page.title = "Forgot password"
        router.push(viewController: page, animated: true)
    }
    
    func showPasswordResetPage() {
        let viewModel = PasswordResetViewModel()
        let page = UIHostingController(rootView: PasswordResetPage(viewModel: viewModel))
        page.title = "Password Reset"
        router.push(viewController: page, animated: true)
    }
    
    func showRegistrationPage() {
        let viewModel = RegistrationViewModel(apiManager: injection.inject(OnboardingApiManagerProtocol.self))
        
        viewModel.showSuccessPage = { [weak self] in
            self?.showSuccessPage()
        }
        
        let page = UIHostingController(rootView: RegistrationPage(viewModel: viewModel))
        page.title = "Registration"
        router.push(viewController: page, animated: true)
    }
    
    func showMainTab() {
        navigationController.setNavigationBarHidden(true, animated: false)
        
        let mainTabCoordinator = MainTabBarCoordinator(
            injection: injection,
            router: MainRouter(),
            navigationController: navigationController
        )
        mainTabCoordinator.start()
    }
    
    func showSuccessPage() {
        let viewModel = AddSuccessViewModel(
            title: "Account created successfully",
            subtitle: "You have successfully created an account, \nclick on the button below to Sign in",
            buttonTitle: "Back to Sign in"
        )
        
        viewModel.buttonTapped = { [weak self] in
            self?.showSignInPage(animated: true)
        }
        
        let page = AddSuccessHostingController(rootView: AddSuccessPage(viewModel: viewModel))
        router.push(viewController: page, animated: true)
    }
    
    func showNewsPage() {
        let viewModel = NewsPageViewModel(apiManager: injection.inject(NewsApiManagerProtocol.self))
        
        viewModel.showArticle = { [weak self] article in
            self?.showArticlePage(article: article)
        }
        
        let page = UIHostingController(rootView: NewsPage(viewModel: viewModel))
        router.set(viewControllers: [page], animated: true)
    }
    
    func showArticlePage(article: Article) {
        let page = UIHostingController(rootView: ArticlePage(article: article))
        router.push(viewController: page, animated: true)
    }
}
