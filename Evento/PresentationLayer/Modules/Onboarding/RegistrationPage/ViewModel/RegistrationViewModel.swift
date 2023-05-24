//
//  RegistrationViewModel.swift
//  Evento
//
//  Created by Ramir Amrayev on 16.05.2023.
//

import SwiftUI
import Combine

final class RegistrationViewModel: ObservableObject {
    // MARK: - Published parameters
    @Published var fullNameModel = InputViewModel()
    @Published var emailModel = InputViewModel()
    @Published var passwordModel = InputViewModel()
    @Published var confirmPasswordModel = InputViewModel()
    @Published var isLoadingButton = false
    
    // MARK: - Callbacks
    var showSignInPage: VoidCallback?
    
    // MARK: - Private parameters
    private let apiManager: OnboardingApiManagerProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(apiManager: OnboardingApiManagerProtocol) {
        self.apiManager = apiManager
    }
    
    func createAccount() {
        guard isValid() else { return }
        
        let registrationPayload = RegisterPayload(
            email: emailModel.text,
            password: passwordModel.text,
            name: fullNameModel.text,
            isCommercial: false
        )
        
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.apiManager.register(payload: registrationPayload).sink(
                receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        print(error)
                    }
                },
                receiveValue: { [weak self] _ in
                    self?.showSignInPage?()
                }
            ).store(in: &self.cancellables)
        }
    }
}

private extension RegistrationViewModel {
    func isValid() -> Bool {
        var isValid = true
        isValid = isValidModel(&fullNameModel) && isValid
        isValid = isValidModel(&emailModel) && isValid
        isValid = isValidModel(&passwordModel) && isValid
        isValid = isValidConfirmPassword() && isValid
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
    
    func isValidConfirmPassword() -> Bool {
        guard isValidModel(&confirmPasswordModel) else { return false }
        
        if confirmPasswordModel.text == passwordModel.text {
            return true
        } else {
            confirmPasswordModel.state = .error(text: "Passwords do not match")
            return false
        }
    }
}
