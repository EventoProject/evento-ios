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
            CustText(text: title, weight: .medium, size: 16)
            InputView(
                text: $text,
                placeholder: placeholder,
                leftIcon: leftIcon,
                isPassword: isPassword
            )
        }
    }
}

private struct InputView: View {
    @Binding var text: String
    let placeholder: String
    let leftIcon: UIImage
    var isPassword: Bool = false
    @State private var isHiddenPassword = true
    
    var body: some View {
        HStack(spacing: 14) {
            Image(uiImage: leftIcon)
            TextFieldView(text: $text, isHiddenPassword: $isHiddenPassword, placeholder: placeholder)
            if isPassword {
                RightIconView(isHiddenPassword: $isHiddenPassword)
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 5)
        .background(Color.white)
        .cornerRadius(15)
    }
    
    private struct TextFieldView: View {
        @Binding var text: String
        @Binding var isHiddenPassword: Bool
        let placeholder: String
        
        var body: some View {
            Group {
                if isHiddenPassword {
                    SecureField(placeholder, text: $text)
                } else {
                    TextField(placeholder, text: $text)
                }
            }
            .padding(.vertical, 10)
        }
    }
    
    private struct RightIconView: View {
        @Binding var isHiddenPassword: Bool
        
        var body: some View {
            Button(action: {
                isHiddenPassword.toggle()
            }, label: {
                if isHiddenPassword {
                    Image(uiImage: Images.closedEye)
                } else {
                    Image(uiImage: Images.openEye)
                }
            })
        }
    }
}
