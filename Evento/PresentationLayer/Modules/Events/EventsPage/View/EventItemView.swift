//
//  EventItemView.swift
//  Evento
//
//  Created by Ramir Amrayev on 07.06.2023.
//

import SwiftUI

struct EventItemView: View {
    let event: EventItemModel
    let didTapLike: Callback<Bool>
    let didTap: VoidCallback
    
    var body: some View {
        Button(
            action: didTap,
            label: {
                VStack(alignment: .leading, spacing: 0) {
                    EventItemImage(imageUrl: event.imageLink)
                        .padding(.bottom, 8)
                    CustText(text: event.name, weight: .medium, size: 17)
                    LikeStackView(event: event, didTapLike: didTapLike)
                    CustText(text: event.description, weight: .regular, size: 14)
                        .lineLimit(2)
                }
                .padding(20)
                .background(.white)
                .cornerRadius(20)
            }
        )
    }
    
    private struct LikeStackView: View {
        let event: EventItemModel
        let didTapLike: Callback<Bool>
        
        private var eventCostText: String {
            if event.cost == "Free" {
                return "Free"
            } else {
                return "\(event.cost) tg"
            }
        }
        
        init(event: EventItemModel, didTapLike: @escaping Callback<Bool>) {
            self.event = event
            self.didTapLike = didTapLike
        }
        
        var body: some View {
            HStack {
                CustText(
                    text: "\(event.format) - \(eventCostText) - \(event.date)",
                    weight: .regular,
                    size: 14
                )
                .foregroundColor(CustColor.lightGray)
                Spacer()
                LikeButton(isLiked: event.liked, didTapLike: didTapLike)
            }
            .padding(.bottom, 10)
        }
    }
}
