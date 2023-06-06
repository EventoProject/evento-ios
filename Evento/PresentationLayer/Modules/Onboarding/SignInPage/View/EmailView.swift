//
//  EmailView.swift
//  Evento
//
//  Created by Ramir Amrayev on 27.04.2023.
//

import SwiftUI

struct EmailView: View {
    @Binding var model: InputViewModel
    var body: some View {
        InputTextField(
            model: $model,
            title: "Email",
            placeholder: "Your E-mail",
            leftIcon: Images.email
        )
        .keyboardType(.emailAddress)
        .textInputAutocapitalization(.never)
    }
}
