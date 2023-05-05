//
//  PasswordResetPage.swift
//  Evento
//
//  Created by Ramir Amrayev on 28.04.2023.
//

import SwiftUI

struct PasswordResetPage: View {
    @ObservedObject var viewModel: PasswordResetViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            PageSubtitleView("Please fill in the fields below to Reset Password ")
            VerificationCodeView(verificationCode: $viewModel.verificationCode)
            PasswordView(
                passwordText: $viewModel.newPassword,
                title: "New password",
                placeholder: "New password"
            )
            PasswordView(
                passwordText: $viewModel.confirmPassword,
                title: "Confirm password",
                placeholder: "Confirm password"
            )
            RememberPasswordView()
            ButtonView(text: "Save password") {
                viewModel.savePassword()
            }.padding(.top, 48)
            Spacer()
        }
        .padding(.horizontal, 26)
        .navigationBarTitle("Password Reset")
        .background(CustColor.backgroundColor)
    }
}

private struct VerificationCodeView: View {
    @Binding var verificationCode: String
    
    var body: some View {
        InputTextView(
            text: $verificationCode,
            title: "Verification code",
            placeholder: "Verification code",
            leftIcon: Images.email
        ).padding(.top, 35)
    }
}

private struct RememberPasswordView: View {
    var body: some View {
        HStack {
            CustText(text: "Remember password", weight: .regular, size: 14)
            
            Spacer()
        }
        .padding(.top, 20)
    }
}

struct PasswordResetPage_Previews: PreviewProvider {
    static var previews: some View {
        PasswordResetPage(viewModel: PasswordResetViewModel())
    }
}
