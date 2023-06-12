//
//  ButtonView.swift
//  Evento
//
//  Created by Ramir Amrayev on 25.04.2023.
//

import SwiftUI

enum ButtonViewType {
    case small
    case big
}

struct ButtonView: View {
    let text: String
    let type: ButtonViewType
    let isFilled: Bool
    @Binding var isLoading: Bool
    var didTap: VoidCallback
    private var cornerRadius: CGFloat {
        type == .big ? 20 : 11
    }
    
    init(
        text: String,
        isLoading: Binding<Bool>? = nil,
        type: ButtonViewType = .big,
        isFilled: Bool = true,
        didTap: @escaping VoidCallback
    ) {
        self.text = text
        self.type = type
        self.isFilled = isFilled
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
                    buttonText
                }
                
                Spacer()
            }
            .padding(.vertical, type == .big ? 18 : 11)
            .background {
                if isFilled {
                    CustLinearGradient
                } else {
                    Color.white
                }
            }.cornerRadius(cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(CustLinearGradient, lineWidth: 1)
            )
        })
        .onChange(of: isLoading) {
            print($0)
        }
    }
    
    private var buttonText: some View {
        Group {
            if isFilled {
                CustText(text: text, weight: .semiBold, size: 16)
                    .foregroundColor(.white)
            } else {
                CustText(text: text, weight: .semiBold, size: 16)
                    .foregroundGradient()
            }
        }
    }
}

extension CustText {
    public func foregroundGradient() -> some View
    {
        self.overlay {
            CustLinearGradient
            .mask(
                self
            )
        }
    }
}
