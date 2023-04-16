//
//  ContentView.swift
//  Evento
//
//  Created by Ramir Amrayev on 08.04.2023.
//

import SwiftUI
import Combine

struct NewsPage: View {
    @ObservedObject var viewModel = NewsPageViewModel(apiManager: NewsApiManager())
    
    var body: some View {
        List(viewModel.articles, id: \.self) { article in
            Text(article.title)
        }
        .listStyle(PlainListStyle())
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
