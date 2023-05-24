//
//  InputTextView.swift
//  Evento
//
//  Created by Ramir Amrayev on 20.04.2023.
//

import SwiftUI

struct InputTextField: View {
    @Binding var model: InputViewModel
    let title: String
    let placeholder: String
    var leftIcon: UIImage? = nil
    var isPassword: Bool = false
    var inputViewBackgroundColor = Color.white
    
    var body: some View {
        VStack(alignment: .leading) {
            CustText(text: title, weight: .medium, size: 16)
            InputView(
                model: $model,
                placeholder: placeholder,
                leftIcon: leftIcon,
                isPassword: isPassword,
                backgroundColor: inputViewBackgroundColor
            )
        }
    }
}
