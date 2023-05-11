//
//  InputTextView.swift
//  Evento
//
//  Created by Ramir Amrayev on 09.05.2023.
//

import SwiftUI

struct InputTextView: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    let limit: Int
    var minNumberOfLines = 8
    
    var body: some View {
        VStack(alignment: .leading) {
            CustText(text: title, weight: .medium, size: 16)
            MultilineInputView(
                text: $text,
                placeholder: placeholder,
                limit: limit,
                minNumberOfLines: minNumberOfLines
            )
        }
    }
}

private struct MultilineInputView: View {
    @Binding var text: String
    let placeholder: String
    let limit: Int
    let minNumberOfLines: Int
    
    var body: some View {
        TextField(
            "free_form",
            text: $text,
            prompt: Text(placeholder),
            axis: .vertical
        )
        .font(MontserratFont.createFont(weight: .regular, size: 16))
        .lineSpacing(10.0)
        .lineLimit(minNumberOfLines...)
        .padding([.top, .horizontal], 16)
        .padding(.bottom, 25)
        .background(CustColor.backgroundColor)
        .cornerRadius(16)
        .overlay(
            Text(String(text.count) + "/" + String(limit))
                .foregroundColor(.secondary)
                .font(MontserratFont.createFont(weight: .regular, size: 12))
                .padding(4)
                .offset(x: -5, y: -5),
            alignment: .bottomTrailing
        )
        .onChange(of: text) { newValue in
            if newValue.count > limit {
                text = String(newValue.prefix(limit))
            }
        }
    }
}
