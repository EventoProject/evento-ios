//
//  SendInputView.swift
//  Evento
//
//  Created by Ramir Amrayev on 12.06.2023.
//

import SwiftUI

struct SendInputView: View {
    @Binding var inputModel: InputViewModel
    let placeholder: String
    let backgroundColor: Color
    var avatarImageUrl: String? = nil
    var didTapSend: VoidCallback?
    
    var body: some View {
        HStack {
            if let avatarImageUrl {
                AsyncAvatarImage(url: avatarImageUrl, size: 40)
            }
            InputView(
                model: $inputModel,
                placeholder: placeholder,
                rightIcon: Images.send,
                backgroundColor: backgroundColor,
                didTapRightIcon: {
                    didTapSend?()
                }
            )
        }
    }
}
