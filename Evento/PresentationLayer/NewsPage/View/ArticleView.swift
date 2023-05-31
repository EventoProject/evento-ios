//
//  ArticleView.swift
//  Evento
//
//  Created by Ramir Amrayev on 17.04.2023.
//

import SwiftUI

struct ArticleView: View {
    let article: Article
    let didTap: VoidCallback
    
    var body: some View {
        HStack {
            Text(article.title)
            Spacer()
        }
        .contentShape(Rectangle())
        .onTapGesture {
            didTap()
        }
    }
}
