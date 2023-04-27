//
//  SignInPage.swift
//  Evento
//
//  Created by Ramir Amrayev on 20.04.2023.
//

import SwiftUI

struct SignInPage: View {
    @ObservedObject var viewModel: SignInViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            PageSubtitleView("Please fill in the fields below")
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
            
            CustText(text: "Or", weight: .medium, size: 16)
            GoogleButtonView() {
                viewModel.didTapGoogleLogin?()
            }
        }
        .padding(.horizontal, 26)
        .navigationBarTitle("Sign in")
        .background(CustColor.backgroundColor)
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

struct GoogleButtonView: View {
    var didTap: VoidCallback
    
    var body: some View {
        Button(action: didTap, label: {
            HStack {
                Spacer()
                
                HStack {
                    Image(uiImage: Images.google)
                    CustText(text: "Login with Google", weight: .medium, size: 16)
                        .foregroundColor(.black)
                }
                
                Spacer()
            }
            .padding(.vertical, 15)
            .background(Color.white)
            .cornerRadius(20)
            .padding(.top, 15)
        })
    }
}


struct SignInPage_Previews: PreviewProvider {
    static var previews: some View {
        SignInPage(viewModel: SignInViewModel())
    }
}
