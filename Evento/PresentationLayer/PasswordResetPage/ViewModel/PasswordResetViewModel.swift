//
//  PasswordResetViewModel.swift
//  Evento
//
//  Created by Ramir Amrayev on 28.04.2023.
//

import SwiftUI

final class PasswordResetViewModel: ObservableObject {
    @Published var verificationCode = ""
    @Published var newPassword = ""
    @Published var confirmPassword = ""
    
    func savePassword() {
        print("Did tap save password")
    }
}
