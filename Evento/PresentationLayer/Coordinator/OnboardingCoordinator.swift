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
        showSignInPage()
    }
}

private extension OnboardingCoordinator {
    func showSignInPage() {
        let viewModel = SignInViewModel()
        
        viewModel.didTapForgotPassword = { [weak self] in
            self?.showForgotPasswordPage()
        }
        
        viewModel.didTapRegister = { [weak self] in
            self?.showRegistrationPage()
        }
        
        let page = UIHostingController(rootView: SignInPage(viewModel: viewModel))
        router.set(viewControllers: [page], animated: false)
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
        let viewModel = RegistrationViewModel()
        let page = UIHostingController(rootView: RegistrationPage(viewModel: viewModel))
        page.title = "Registration"
        router.push(viewController: page, animated: true)
    }
    
    func showArticlePage(article: Article) {
        let page = UIHostingController(rootView: ArticlePage(article: article))
        router.push(viewController: page, animated: true)
    }
}
