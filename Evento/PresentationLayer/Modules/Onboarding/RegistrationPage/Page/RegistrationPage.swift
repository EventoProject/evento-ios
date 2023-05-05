//
//  RegistrationPage.swift
//  Evento
//
//  Created by Ramir Amrayev on 28.04.2023.
//

import SwiftUI

final class RegistrationViewModel: ObservableObject {
    @Published var fullName = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    
    func createAccount() {
        print("Did tap create account")
    }
}

struct RegistrationPage: View {
    @ObservedObject var viewModel: RegistrationViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            PageSubtitleView("Please fill in the fields below to create a new account")
            FullNameView(fullName: $viewModel.fullName)
            EmailView(emailText: $viewModel.email)
                .padding(.top, 25)
            PasswordView(passwordText: $viewModel.password, placeholder: "New password")
            PasswordView(
                passwordText: $viewModel.confirmPassword,
                title: "Confirm password",
                placeholder: "Confirm password"
            )
            ButtonView(text: "Create an account") {
                viewModel.createAccount()
            }.padding(.top, 43)
            Spacer()
        }
        .padding(.horizontal, 26)
        .navigationBarTitle("Registration")
        .background(CustColor.backgroundColor)
    }
}

private struct FullNameView: View {
    @Binding var fullName: String
    
    var body: some View {
        InputTextView(
            text: $fullName,
            title: "Full Name",
            placeholder: "Your Full Name",
            leftIcon: Images.personCircle
        ).padding(.top, 35)
    }
}

struct RegistrationPage_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationPage(viewModel: RegistrationViewModel())
    }
}
