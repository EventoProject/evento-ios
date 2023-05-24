//
//  ForgotPasswordViewModel.swift
//  Evento
//
//  Created by Ramir Amrayev on 28.04.2023.
//

import Foundation

final class ForgotPasswordViewModel: ObservableObject {
    @Published var emailModel = InputViewModel()
    @Published var isLoadingButton = false
    
    // MARK: - Callbacks
    var resetPassword: VoidCallback?
    
    func getVerificationCode() {
        guard isValidModel(&emailModel) else { return }
        resetPassword?()
    }
}

private extension ForgotPasswordViewModel {
    func isValidModel(_ model: inout InputViewModel) -> Bool {
        if model.text.isEmpty {
            model.state = .error(text: "Required field")
            return false
        } else {
            return true
        }
    }
}
