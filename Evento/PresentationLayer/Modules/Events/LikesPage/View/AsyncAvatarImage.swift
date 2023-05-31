//
//  AsyncAvatarImage.swift
//  Evento
//
//  Created by Ramir Amrayev on 30.05.2023.
//

import SwiftUI

struct AsyncAvatarImage: View {
    let url: String
    let size: CGFloat
    
    var body: some View {
        AsyncImage(
            url: URL(string: url),
            content: { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: size, height: size)
                    .cornerRadius(size/2)
            },
            placeholder: {
                Image(uiImage: Images.personCircle)
                    .resizable()
                    .scaledToFill()
                    .frame(width: size, height: size)
                    .cornerRadius(size/2)
            }
        )
    }
}
