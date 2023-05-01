//
//  ForgotPasswordPage.swift
//  Evento
//
//  Created by Ramir Amrayev on 27.04.2023.
//

import SwiftUI

struct ForgotPasswordPage: View {
    @ObservedObject var viewModel: ForgotPasswordViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            PageSubtitleView("Enter your E-mail address to get the verification code")
            EmailView(emailText: $viewModel.email)
                .padding(.top, 32)
            ButtonView(text: "Get verification code") {
                viewModel.getVerificationCode()
            }.padding(.top, 28)
            EndLinkText(startText: "The code didn't come?", endLinkText: "Send again") {
                viewModel.getVerificationCode()
            }
            Spacer()
        }
        .padding(.horizontal, 26)
        .navigationBarTitle("Forgot password")
        .background(CustColor.backgroundColor)
    }
}

struct ForgotPasswordPage_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordPage(viewModel: ForgotPasswordViewModel())
    }
}
