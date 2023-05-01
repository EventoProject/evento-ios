//
//  EndLinkText.swift
//  Evento
//
//  Created by Ramir Amrayev on 28.04.2023.
//

import SwiftUI

struct EndLinkText: View {
    let startText: String
    let endLinkText: String
    var fontSize: CGFloat = 16
    var didTapLink: VoidCallback
    
    var body: some View {
        HStack {
            CustText(text: startText, weight: .regular, size: fontSize)
            
            UnderlinedTextView(
                text: endLinkText,
                font: MontserratFont.createFont(weight: .regular, size: 16),
                didTap: didTapLink
            )
        }.padding(.top, 17)
    }
}
