//
//  ButtonView.swift
//  Evento
//
//  Created by Ramir Amrayev on 25.04.2023.
//

import SwiftUI

struct ButtonView: View {
    let text: String
    @Binding var isLoading: Bool
    var didTap: VoidCallback
    
    init(text: String, isLoading: Binding<Bool>? = nil, didTap: @escaping VoidCallback) {
        self.text = text
        self.didTap = didTap
        if let isLoading {
            self._isLoading = isLoading
        } else {
            let defaultIsLoading = Binding<Bool>(
                get: {
                    false
                },
                set: { _ in
                    print("Error: trying to set binding property")
                }
            )
            self._isLoading = defaultIsLoading
        }
    }
    
    var body: some View {
        Button(action: didTap, label: {
            HStack {
                Spacer()
                
                if isLoading {
                    ProgressView()
                        .tint(.white)
                } else {
                    CustText(text: text, weight: .semiBold, size: 16)
                        .foregroundColor(.white)
                }
                
                Spacer()
            }
            .padding(.vertical, 18)
            .background(
                CustLinearGradient
            ).cornerRadius(20)
        })
        .onChange(of: isLoading) {
            print($0)
        }
    }
}
