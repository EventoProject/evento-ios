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
}

struct SignInPage: View {
    @ObservedObject var viewModel: SignInViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            SubtitleView()
            EmailView(emailText: $viewModel.emailText)
            PasswordView(passwordText: $viewModel.passwordText)
            Spacer()
        }
        .padding(.horizontal, 26)
        .navigationBarTitle("Sign in")
        .background(CustColor.backgroundColor)
    }
}

private struct SubtitleView: View {
    var body: some View {
        Text("Please fill in the fields below")
            .font(MontserratFont.createFont(weight: .regular, size: 16))
            .foregroundColor(CustColor.lightGray)
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

struct SignInPage_Previews: PreviewProvider {
    static var previews: some View {
        SignInPage(viewModel: SignInViewModel())
    }
}
