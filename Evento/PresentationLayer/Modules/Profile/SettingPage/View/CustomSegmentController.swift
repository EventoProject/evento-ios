//
//  CustomSegmentController.swift
//  Evento
//
//  Created by RAmrayev on 28.05.2023.
//

import Foundation
import SwiftUI

struct CustomSegmentController: View {
    @Binding var selectedSegmentIndex: Int
    let segments: [String]
    var body: some View {
        VStack{
            ZStack(alignment: .leading) {
                LinearGradient(gradient: Gradient(colors: []), startPoint: .leading, endPoint: .trailing)
                    .frame(height: 40)
                    .overlay(
                            RoundedRectangle(cornerRadius: 10)
                            .stroke(CustLinearGradient, lineWidth: 1)
                        )
                HStack {
                    ForEach(0..<2) { index in
                        Button(action: {
                            selectedSegmentIndex = index
                        }) {
                            Text(segments[index])
                                .foregroundColor(index == selectedSegmentIndex ? .white : .gray)
                                .frame(maxWidth: .infinity, maxHeight: 35)
                                .background(index == selectedSegmentIndex ?  CustLinearGradient : LinearGradient(gradient: Gradient(colors: []),startPoint: .leading,endPoint: .trailing))
                        }
                        .cornerRadius(8)
                        .frame(maxWidth: .infinity, maxHeight: 35)
                        .padding(.maximumMagnitude(0, 2))
                    }
                }
            }
            .frame(height: 50)       
        }
    }
}
