//
//  PasswordView.swift
//  Evento
//
//  Created by Ramir Amrayev on 28.04.2023.
//

import SwiftUI

struct PasswordView: View {
    @Binding var model: InputViewModel
    var title = "Password"
    var placeholder = "Enter password"
    
    var body: some View {
        InputTextField(
            model: $model,
            title: title,
            placeholder: placeholder,
            leftIcon: Images.key,
            isPassword: true
        ).padding(.top, 25)
    }
}
