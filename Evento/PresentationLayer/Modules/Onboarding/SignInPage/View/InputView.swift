//
//  InputView.swift
//  Evento
//
//  Created by Ramir Amrayev on 12.05.2023.
//

import SwiftUI

enum InputViewState: Hashable {
    case `default`
    case error(text: String)
}

struct InputViewModel: Hashable {
    var text = ""
    var state: InputViewState = .default
}

struct InputView: View {
    // MARK: - Public parameters
    @Binding var model: InputViewModel
    let placeholder: String
    var leftIcon: UIImage?
    var isPassword: Bool = false
    var backgroundColor: Color
    
    var body: some View {
        VStack(alignment: .leading) {
            InputFieldView(
                model: $model,
                placeholder: placeholder,
                leftIcon: leftIcon,
                isPassword: isPassword,
                backgroundColor: backgroundColor
            )
            
            if case let .error(text) = model.state {
                ErrorTextView(text: text)
            }
        }
    }
}

private struct InputFieldView: View {
    // MARK: - Public parameters
    @Binding var model: InputViewModel
    let placeholder: String
    var leftIcon: UIImage?
    var isPassword: Bool = false
    var backgroundColor: Color
    
    // MARK: - Private parameters
    @State private var isHiddenPassword = true
    
    var body: some View {
        HStack(spacing: 14) {
            if let leftIcon {
                Image(uiImage: leftIcon)
            }
            TextFieldView(
                text: $model.text,
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
        .background(
            RoundedRectangle(cornerRadius: 15)
                .strokeBorder(model.state == .default ? backgroundColor : CustColor.errorColor , lineWidth: 1)
                .background(backgroundColor)
        )
        .cornerRadius(15)
    }
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

private struct ErrorTextView: View {
    let text: String
    
    var body: some View {
        HStack(spacing: 3) {
            Image(uiImage: Images.errorIcon)
            CustText(text: text, weight: .regular, size: 12)
                .foregroundColor(CustColor.errorColor)
        }
    }
}
