//
//  InputTextView.swift
//  Evento
//
//  Created by Ramir Amrayev on 09.05.2023.
//

import SwiftUI

struct InputTextView: View {
    @Binding var model: InputViewModel
    let title: String
    let placeholder: String
    let limit: Int
    var minNumberOfLines = 8
    
    var body: some View {
        VStack(alignment: .leading) {
            CustText(text: title, weight: .medium, size: 16)
            MultilineInputView(
                model: $model,
                placeholder: placeholder,
                limit: limit,
                minNumberOfLines: minNumberOfLines
            )
            
            if case let .error(text) = model.state {
                ErrorTextView(text: text)
            }
        }
    }
}

private struct MultilineInputView: View {
    @Binding var model: InputViewModel
    let placeholder: String
    let limit: Int
    let minNumberOfLines: Int
    
    var body: some View {
        TextField(
            "free_form",
            text: $model.text,
            prompt: Text(placeholder),
            axis: .vertical
        )
        .font(MontserratFont.createFont(weight: .regular, size: 16))
        .lineSpacing(10.0)
        .lineLimit(minNumberOfLines...)
        .padding([.top, .horizontal], 16)
        .padding(.bottom, 25)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .strokeBorder(model.state == .default ? CustColor.backgroundColor : CustColor.errorColor , lineWidth: 1)
                .background(CustColor.backgroundColor)
        )
        .cornerRadius(16)
        .overlay(
            Text(String(model.text.count) + "/" + String(limit))
                .foregroundColor(.secondary)
                .font(MontserratFont.createFont(weight: .regular, size: 12))
                .padding(4)
                .offset(x: -5, y: -5),
            alignment: .bottomTrailing
        )
        .onChange(of: model.text) { newValue in
            if newValue.count > limit {
                model.text = String(newValue.prefix(limit))
            }
            if !newValue.isEmpty {
                model.state = .default
            }
        }
    }
}
