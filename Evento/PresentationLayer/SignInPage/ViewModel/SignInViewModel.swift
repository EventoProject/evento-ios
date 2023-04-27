//
//  SignInViewModel.swift
//  Evento
//
//  Created by Ramir Amrayev on 27.04.2023.
//

import Foundation

final class SignInViewModel: ObservableObject {
    @Published var emailText = ""
    @Published var passwordText = ""
    
    var didTapForgotPassword: VoidCallback?
    var didTapSignIn: Callback<(email: String, password: String)>?
    var didTapRegister: VoidCallback?
    var didTapGoogleLogin: VoidCallback?
    
    func didTapSignInButton() {
        didTapSignIn?((emailText, passwordText))
    }
}
