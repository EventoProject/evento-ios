//
//  EventItemImage.swift
//  Evento
//
//  Created by Ramir Amrayev on 24.05.2023.
//

import SwiftUI

struct EventItemImage: View {
    let imageUrl: String
    private let imageWidth = UIScreen.screenWidth - 94
    private let imageHeight = 0.6 * (UIScreen.screenWidth - 94)
    
    var body: some View {
        AsyncImage(
            url: URL(string: imageUrl),
            content: { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: imageWidth,
                        height: imageHeight
                    )
                    .cornerRadius(20)
            },
            placeholder: {
                CustColor.backgroundColor
                    .frame(
                        width: imageWidth,
                        height: imageHeight
                    )
                    .cornerRadius(20)
            }
        )
    }
}
