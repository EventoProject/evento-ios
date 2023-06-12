//
//  ShareItemView.swift
//  Evento
//
//  Created by Ramir Amrayev on 12.06.2023.
//

import SwiftUI

struct ShareItemView: View {
    let shareModel: ShareItemModel
    let didTapUser: VoidCallback
    let didTapEvent: VoidCallback
    
    private var eventCostText: String {
        if shareModel.cost == "Free" {
            return "Free"
        } else {
            return "\(shareModel.cost) tg"
        }
    }
    
    var body: some View {
        Button(
            action: didTapEvent,
            label: {
                VStack(alignment: .leading) {
                    userHeader
                    CustText(
                        text: shareModel.shareDescription,
                        weight: .regular,
                        size: 16
                    )
                    HStack(spacing: 15) {
                        lightGrayLineView
                        eventView
                    }
                }
                .foregroundColor(.black)
            }
        )
    }
    
    private var userHeader: some View {
        HStack {
            userAvatarNameView
            Spacer()
            CustText(
                text: shareModel.sharedAt.toDate(with: .yyyyMMddTHHmmssSSSZ)?.timeElapsedString() ?? "",
                weight: .regular, size: 14
            ).foregroundColor(CustColor.lightGray)
        }
    }
    
    private var userAvatarNameView: some View {
        Button(
            action: didTapUser,
            label: {
                HStack {
                    AsyncAvatarImage(
                        url: shareModel.userImageLink,
                        size: 47
                    )
                    NameUsernameView(name: shareModel.userName, username: shareModel.username)
                }
            }
        )
    }
    
    private var lightGrayLineView: some View {
        VStack {
            Spacer()
        }
        .frame(width: 1)
        .background(CustColor.lightGray)
    }
    
    private var eventView: some View {
        VStack(alignment: .leading) {
            EventItemImage(imageUrl: shareModel.imageLink)
                .padding(.bottom, 10)
            CustText(text: shareModel.name, weight: .regular, size: 16)
            CustText(
                text: "\(shareModel.format) - \(eventCostText) - \(shareModel.date)",
                weight: .regular,
                size: 14
            )
            .foregroundColor(CustColor.lightGray)
            .padding(.bottom, 8)
            CustText(text:  shareModel.description, weight: .regular, size: 14)
                .lineLimit(2)
        }
    }
}
