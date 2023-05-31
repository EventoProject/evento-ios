//
//  CustText.swift
//  Evento
//
//  Created by Ramir Amrayev on 26.04.2023.
//

import SwiftUI

struct CustText: View {
    let text: String
    let weight: FontWeight
    let size: CGFloat
    
    var body: some View {
        Text(text)
            .font(MontserratFont.createFont(weight: weight, size: size))
    }
}
