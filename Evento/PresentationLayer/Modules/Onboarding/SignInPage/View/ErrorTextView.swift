//
//  ErrorTextView.swift
//  Evento
//
//  Created by Ramir Amrayev on 22.05.2023.
//

import SwiftUI

struct ErrorTextView: View {
    let text: String
    
    var body: some View {
        HStack(spacing: 3) {
            Image(uiImage: Images.errorIcon)
            CustText(text: text, weight: .regular, size: 12)
                .foregroundColor(CustColor.errorColor)
        }
    }
}
