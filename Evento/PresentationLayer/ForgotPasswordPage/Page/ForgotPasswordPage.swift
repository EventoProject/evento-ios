//
//  ForgotPasswordPage.swift
//  Evento
//
//  Created by Ramir Amrayev on 27.04.2023.
//

import SwiftUI

final class ForgotPasswordViewModel: ObservableObject {
    @Published var email = ""
}

struct ForgotPasswordPage: View {
    @ObservedObject var viewModel: ForgotPasswordViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            PageSubtitleView("Enter your E-mail address to get the verification code")
            EmailView(emailText: $viewModel.email)
            Spacer()
        }
        .padding(.horizontal, 26)
        .navigationBarTitle("Forgot password")
        .background(CustColor.backgroundColor)
    }
}
