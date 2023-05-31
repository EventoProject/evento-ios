//
//  ArticlePage.swift
//  Evento
//
//  Created by Ramir Amrayev on 17.04.2023.
//

import SwiftUI

struct ArticlePage: View {
    let article: Article
    
    var body: some View {
        Text(article.title)
    }
}
