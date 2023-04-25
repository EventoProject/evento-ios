//
//  CustLinearGradient.swift
//  Evento
//
//  Created by Ramir Amrayev on 25.04.2023.
//

import SwiftUI

let CustLinearGradient = LinearGradient(
    gradient: Gradient(
        colors: [
            Color(red: 95/256, green: 179/256, blue: 240/256),
            Color(red: 105/256, green: 136/256, blue: 217/256),
            Color(red: 94/256, green: 89/256, blue: 220/256)
        ]
    ),
    startPoint: .leading,
    endPoint: .trailing
)
