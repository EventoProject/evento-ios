//
//  UnderlinedTextView.swift
//  Evento
//
//  Created by Ramir Amrayev on 25.04.2023.
//

import SwiftUI

struct UnderlinedTextView: View {
    let text: String
    let font: Font
    let didTap: VoidCallback
    
    var body: some View {
        Button(
            action: didTap,
            label: {
                Text(text)
                    .font(font)
                    .underline()
                    .foregroundStyle(CustLinearGradient)
            }
        )
    }
}
