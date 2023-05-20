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
        resetPassword?()
    }
}
