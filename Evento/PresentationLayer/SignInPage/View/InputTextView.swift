//
//  InputTextView.swift
//  Evento
//
//  Created by Ramir Amrayev on 20.04.2023.
//

import SwiftUI

struct InputTextView: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    let leftIcon: UIImage
    var isPassword: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            TitleView(title: title)
            TextFieldView(
                text: $text,
                placeholder: placeholder,
                leftIcon: leftIcon,
                isPassword: isPassword
            )
        }
    }
}

private struct TitleView: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(MontserratFont.createFont(weight: .medium, size: 16))
    }
}

private struct TextFieldView: View {
    @Binding var text: String
    let placeholder: String
    let leftIcon: UIImage
    var isPassword: Bool = false
    @State private var isHiddenPassword = true
    
    var body: some View {
        HStack(spacing: 14) {
            Image(uiImage: leftIcon)
            TextField(placeholder, text: $text)
                .padding(.vertical, 10)
            if isPassword {
                RightIconView(isHiddenPassword: $isHiddenPassword)
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 5)
        .background(Color.white)
        .cornerRadius(15)
    }
    
    private struct RightIconView: View {
        @Binding var isHiddenPassword: Bool
        
        var body: some View {
            Button(action: {
                isHiddenPassword.toggle()
            }, label: {
                Image(uiImage: Images.closedEye)
            })
        }
    }
}
