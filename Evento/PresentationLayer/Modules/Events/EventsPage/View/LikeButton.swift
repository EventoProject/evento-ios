//
//  LikeButton.swift
//  Evento
//
//  Created by Ramir Amrayev on 24.05.2023.
//

import SwiftUI

enum LikeButtonType {
    case like
    case save
}

struct LikeButton: View {
    var isLiked: Bool
    var type: LikeButtonType = .like
    let didTapLike: Callback<Bool>
    
    var body: some View {
        Button(
            action: {
                didTapLike(!isLiked)
            },
            label: {
                Group {
                    if isLiked {
                        Image(uiImage: type == .like ? Images.likeFilled : Images.saveFilled)
                    } else {
                        Image(uiImage: type == .like ? Images.like : Images.save)
                    }
                }
                .frame(width: 25, height: 25)
            }
        )
    }
}
