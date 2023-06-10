//
//  SignInViewModel.swift
//  Evento
//
//  Created by Ramir Amrayev on 27.04.2023.
//

import Foundation
import Combine

private enum Constants {
    static let avatarImageUrlKey = "avatarImageUrlKey"
}

final class SignInViewModel: ObservableObject {
    // MARK: - Published parameters
    @Published var emailModel = InputViewModel()
    @Published var passwordModel = InputViewModel()
    @Published var isLoadingButton = false
    
    // MARK: - Callbacks
    var didTapForgotPassword: VoidCallback?
    var didTapSignIn: VoidCallback?
    var didTapRegister: VoidCallback?
    var didTapGoogleLogin: VoidCallback?
    
    // MARK: - Private parameters
    private let apiManager: OnboardingApiManagerProtocol
    private let webService: WebServiceProtocol
    private let keychainManager: KeychainManagerProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(
        apiManager: OnboardingApiManagerProtocol,
        webService: WebServiceProtocol,
        keychainManager: KeychainManagerProtocol
    ) {
        self.apiManager = apiManager
        self.webService = webService
        self.keychainManager = keychainManager
    }
    
    func didTapSignInButton() {
        guard isValid() else { return }
        
        isLoadingButton = true
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.apiManager.login(
                email: self.emailModel.text,
                password: self.passwordModel.text
            ).sink(
                receiveCompletion: { [weak self] completion in
                    if case let .failure(error) = completion {
                        print(error)
                    }
                    self?.isLoadingButton = false
                }, receiveValue: { [weak self] responseModel in
                    guard let self else { return }
                    let user = responseModel.user
                    self.save(accessToken: responseModel.accessToken)
                    self.save(imageUrl: user.imageLink)
                    self.saveUserInfoToKeychain(user)
                    self.didTapSignIn?()
                }
            ).store(in: &self.cancellables)
        }
    }
}

private extension SignInViewModel {
    func save(accessToken: String) {
        webService.set(accessToken: accessToken)
    }
    
    func save(imageUrl: String) {
        UserDefaults.standard.set(imageUrl, forKey: Constants.avatarImageUrlKey)
    }
    
    func saveUserInfoToKeychain(_ user: UserModel) {
        keychainManager.set(value: "\(user.id)", type: .userId)
        keychainManager.set(value: user.username, type: .username)
    }
    
    func isValid() -> Bool {
        var isValid = true
        isValid = isValidModel(&emailModel) && isValid
        isValid = isValidModel(&passwordModel) && isValid
        return isValid
    }
    
    func isValidModel(_ model: inout InputViewModel) -> Bool {
        if model.text.isEmpty {
            model.state = .error(text: "Required field")
            return false
        } else {
            return true
        }
    }
}
