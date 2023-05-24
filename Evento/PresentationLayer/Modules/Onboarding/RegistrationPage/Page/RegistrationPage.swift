//
//  RegistrationPage.swift
//  Evento
//
//  Created by Ramir Amrayev on 28.04.2023.
//

import SwiftUI

struct RegistrationPage: View {
    @ObservedObject var viewModel: RegistrationViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            OnboardingPageSubtitleView("Please fill in the fields below to create a new account")
            FullNameView(model: $viewModel.fullNameModel)
            EmailView(model: $viewModel.emailModel)
                .padding(.top, 25)
            PasswordView(model: $viewModel.passwordModel, placeholder: "New password")
            PasswordView(
                model: $viewModel.confirmPasswordModel,
                title: "Confirm password",
                placeholder: "Confirm password"
            )
            ButtonView(text: "Create an account", isLoading: $viewModel.isLoadingButton) {
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
    @Binding var model: InputViewModel
    
    var body: some View {
        InputTextField(
            model: $model,
            title: "Full Name",
            placeholder: "Your Full Name",
            leftIcon: Images.personCircle
        ).padding(.top, 35)
    }
}

struct RegistrationPage_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationPage(viewModel: RegistrationViewModel(
            apiManager: OnboardingApiManager(
                webService: WebService(
                    keychainManager: KeychainManager()
                )
            )
        ))
    }
}
