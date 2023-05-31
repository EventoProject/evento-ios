//
//  PasswordResetViewModel.swift
//  Evento
//
//  Created by Ramir Amrayev on 28.04.2023.
//

import SwiftUI

final class PasswordResetViewModel: ObservableObject {
    @Published var verificationCodeModel = InputViewModel()
    @Published var newPasswordModel = InputViewModel()
    @Published var confirmPasswordModel = InputViewModel()
    @Published var isLoadingButton = false
    
    func savePassword() {
        guard isValid() else { return }
        
        print("Did tap save password")
    }
}

private extension PasswordResetViewModel {
    func isValid() -> Bool {
        var isValid = true
        isValid = isValidModel(&verificationCodeModel) && isValid
        isValid = isValidModel(&newPasswordModel) && isValid
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
        
        if confirmPasswordModel.text == newPasswordModel.text {
            return true
        } else {
            confirmPasswordModel.state = .error(text: "Passwords do not match")
            return false
        }
    }
}
