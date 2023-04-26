//
//  SignInPage.swift
//  Evento
//
//  Created by Ramir Amrayev on 20.04.2023.
//

import SwiftUI

final class SignInViewModel: ObservableObject {
    @Published var emailText = ""
    @Published var passwordText = ""
    
    var didTapForgotPassword: VoidCallback?
    var didTapSignIn: Callback<(email: String, password: String)>?
    var didTapRegister: VoidCallback?
    
    func didTapSignInButton() {
        didTapSignIn?((emailText, passwordText))
    }
}

struct SignInPage: View {
    @ObservedObject var viewModel: SignInViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            SubtitleView()
            
            EmailView(emailText: $viewModel.emailText)
            
            PasswordView(passwordText: $viewModel.passwordText)
            
            ForgotPasswordView() {
                viewModel.didTapForgotPassword?()
            }
            
            ButtonView(text: "Sign in") {
                viewModel.didTapSignInButton()
            }.padding(.top, 55)
            
            NewUserView() {
                viewModel.didTapRegister?()
            }
            
            Spacer()
        }
        .padding(.horizontal, 26)
        .navigationBarTitle("Sign in")
        .background(CustColor.backgroundColor)
    }
}

private struct SubtitleView: View {
    var body: some View {
        HStack {
            CustText(
                text: "Please fill in the fields below",
                weight: .regular,
                size: 16
            ).foregroundColor(CustColor.lightGray)
            
            Spacer()
        }
    }
}

private struct EmailView: View {
    @Binding var emailText: String
    var body: some View {
        InputTextView(
            text: $emailText,
            title: "Email",
            placeholder: "Your E-mail",
            leftIcon: Images.email
        ).padding(.top, 32)
    }
}

private struct PasswordView: View {
    @Binding var passwordText: String
    var body: some View {
        InputTextView(
            text: $passwordText,
            title: "Password",
            placeholder: "Enter password",
            leftIcon: Images.key,
            isPassword: true
        ).padding(.top, 25)
    }
}

private struct ForgotPasswordView: View {
    var didTapForgotPassword: VoidCallback
    
    var body: some View {
        HStack {
            HStack {
                CustText(text: "Remember password", weight: .regular, size: 14)
            }
            
            Spacer()
            
            UnderlinedTextView(
                text: "Forgot password?",
                font: MontserratFont.createFont(weight: .regular, size: 14),
                didTap: didTapForgotPassword
            )
        }
        .padding(.top, 15)
    }
}

private struct NewUserView: View {
    var didTapRegister: VoidCallback
    
    var body: some View {
        HStack {
            CustText(text: "New user?", weight: .regular, size: 16)
            
            UnderlinedTextView(
                text: "Register now",
                font: MontserratFont.createFont(weight: .regular, size: 16),
                didTap: didTapRegister
            )
        }.padding(.top, 17)
    }
}

struct SignInPage_Previews: PreviewProvider {
    static var previews: some View {
        SignInPage(viewModel: SignInViewModel())
    }
}
