//
//  RoundedBorderButton.swift
//  Evento
//
//  Created by Ramir Amrayev on 20.05.2023.
//

import SwiftUI

struct RoundedBorderButton: View {
    @Binding var isSelected: Bool
    let text: String
    let didTap: VoidCallback
    
    var body: some View {
        Button(
            action: didTap,
            label: {
                RoundedBorderText(isSelected: $isSelected, text: text)
            }
        )
    }
}

private struct RoundedBorderText: View {
    @Binding var isSelected: Bool
    let text: String
    
    var body: some View {
        CustText(text: text, weight: .regular, size: 16)
            .foregroundColor(isSelected ? Color.white : Color.black)
            .padding(.vertical, 6)
            .padding(.horizontal, 20)
            .background {
                if isSelected {
                    CustLinearGradient
                } else {
                    Color.white
                }
            }
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(CustLinearGradient, lineWidth: 1)
            )
    }
}
