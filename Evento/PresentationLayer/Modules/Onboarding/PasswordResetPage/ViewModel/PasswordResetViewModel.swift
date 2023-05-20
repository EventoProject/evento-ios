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
        print("Did tap save password")
    }
}
