//
//  ButtonView.swift
//  Evento
//
//  Created by Ramir Amrayev on 25.04.2023.
//

import SwiftUI

struct ButtonView: View {
    let text: String
    var didTap: VoidCallback
    
    var body: some View {
        Button(action: didTap, label: {
            HStack {
                Spacer()
                
                CustText(text: text, weight: .semiBold, size: 16)
                    .foregroundColor(.white)
                
                Spacer()
            }
            .padding(.vertical, 18)
            .background(
                CustLinearGradient
            ).cornerRadius(20)
        })
    }
}
