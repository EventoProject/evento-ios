//
//  RoundedBorderButton.swift
//  Evento
//
//  Created by Ramir Amrayev on 13.05.2023.
//

import SwiftUI

struct RoundedBorderText: View {
    @Binding var isSelected: Bool
    let text: String
    
    var body: some View {
        CustText(text: text, weight: .regular, size: 16)
            .foregroundColor(Color.black)
            .padding(.vertical, 6)
            .padding(.horizontal, 20)
            .background(isSelected ? Color.yellow : Color.white)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(CustLinearGradient, lineWidth: 1)
            )
    }
}
