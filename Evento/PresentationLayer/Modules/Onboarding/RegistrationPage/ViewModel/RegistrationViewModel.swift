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
        let registrationPayload = RegisterPayload(
            email: emailModel.text,
            password: passwordModel.text,
            name: fullNameModel.text,
            isCommercial: false
        )
        
        apiManager.register(payload: registrationPayload).sink(
            receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print(error)
                }
            },
            receiveValue: { [weak self] _ in
                self?.showSignInPage?()
            }
        ).store(in: &cancellables)
    }
}
