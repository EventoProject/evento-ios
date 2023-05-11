//
//  EmailView.swift
//  Evento
//
//  Created by Ramir Amrayev on 27.04.2023.
//

import SwiftUI

struct EmailView: View {
    @Binding var emailText: String
    var body: some View {
        InputTextField(
            text: $emailText,
            title: "Email",
            placeholder: "Your E-mail",
            leftIcon: Images.email
        )
    }
}
