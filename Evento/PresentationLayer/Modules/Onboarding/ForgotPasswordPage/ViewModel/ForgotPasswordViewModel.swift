//
//  ForgotPasswordViewModel.swift
//  Evento
//
//  Created by Ramir Amrayev on 28.04.2023.
//

import Foundation

final class ForgotPasswordViewModel: ObservableObject {
    @Published var email = ""
    
    // MARK: - Callbacks
    var resetPassword: VoidCallback?
    
    func getVerificationCode() {
        resetPassword?()
    }
}
