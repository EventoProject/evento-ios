//
//  AddStepIndicatorView.swift
//  Evento
//
//  Created by Ramir Amrayev on 07.05.2023.
//

import SwiftUI

struct AddStepIndicatorView: View {
    let stepNumber: Int
    
    var body: some View {
        HStack {
            ForEach(0..<4) { index in
                StepIndicatorView(isActive: index < stepNumber)
            }
        }
    }
}

private struct StepIndicatorView: View {
    let isActive: Bool
    
    var body: some View {
        Group {
            if isActive {
                CustLinearGradient
            } else {
                CustColor.lightLilac
            }
        }
        .frame(height: 4)
        .cornerRadius(2)
    }
}

struct AddStepIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        AddStepIndicatorView(stepNumber: 3)
    }
}
