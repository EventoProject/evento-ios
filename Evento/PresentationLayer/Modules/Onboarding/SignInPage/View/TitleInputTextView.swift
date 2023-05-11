//
//  InputTextView.swift
//  Evento
//
//  Created by Ramir Amrayev on 20.04.2023.
//

import SwiftUI

struct InputTextField: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    var leftIcon: UIImage? = nil
    var isPassword: Bool = false
    var inputViewBackgroundColor = Color.white
    
    var body: some View {
        VStack(alignment: .leading) {
            CustText(text: title, weight: .medium, size: 16)
            InputView(
                text: $text,
                placeholder: placeholder,
                leftIcon: leftIcon,
                isPassword: isPassword,
                backgroundColor: inputViewBackgroundColor
            )
        }
    }
}

private struct InputView: View {
    @Binding var text: String
    let placeholder: String
    let leftIcon: UIImage?
    var isPassword: Bool = false
    @State private var isHiddenPassword = true
    var backgroundColor: Color
    
    var body: some View {
        HStack(spacing: 14) {
            if let leftIcon {
                Image(uiImage: leftIcon)
            }
            TextFieldView(
                text: $text,
                isHiddenPassword: $isHiddenPassword,
                placeholder: placeholder,
                isPassword: isPassword
            )
            if isPassword {
                RightIconView(isHiddenPassword: $isHiddenPassword)
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 5)
        .background(backgroundColor)
        .cornerRadius(15)
    }
    
    private struct TextFieldView: View {
        @Binding var text: String
        @Binding var isHiddenPassword: Bool
        let placeholder: String
        let isPassword: Bool
        @State private var isPlaceholderHidden = false
        
        var body: some View {
            ZStack {
                PlaceholderView(isHidden: $isPlaceholderHidden, placeholder: placeholder)
                InputFieldView(
                    text: $text,
                    isHiddenPassword: $isHiddenPassword,
                    isPlaceholderHidden: $isPlaceholderHidden,
                    placeholder: placeholder,
                    isPassword: isPassword
                )
            }
            .padding(.vertical, 10)
        }
        
        private struct PlaceholderView: View {
            @Binding var isHidden: Bool
            let placeholder: String
            
            var body: some View {
                HStack {
                    CustText(text: placeholder, weight: .regular, size: 16)
                        .foregroundColor(.gray)
                        .opacity(isHidden ? 0 : 1)
                    
                    Spacer()
                }
            }
        }
        
        private struct InputFieldView: View {
            @Binding var text: String
            @Binding var isHiddenPassword: Bool
            @Binding var isPlaceholderHidden: Bool
            let placeholder: String
            let isPassword: Bool
            
            var body: some View {
                Group {
                    if isHiddenPassword && isPassword {
                        SecureField("", text: $text)
                    } else {
                        TextField("", text: $text)
                    }
                }
                .font(MontserratFont.createFont(weight: .regular, size: 16))
                .onChange(of: text) { newText in
                    isPlaceholderHidden = !newText.isEmpty
                }
            }
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
