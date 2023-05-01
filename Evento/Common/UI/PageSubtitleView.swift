//
//  PageSubtitleView.swift
//  Evento
//
//  Created by Ramir Amrayev on 27.04.2023.
//

import SwiftUI

struct PageSubtitleView: View {
    let text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        HStack {
            CustText(
                text: text,
                weight: .regular,
                size: 16
            ).foregroundColor(CustColor.lightGray)
            
            Spacer()
        }
    }
}
