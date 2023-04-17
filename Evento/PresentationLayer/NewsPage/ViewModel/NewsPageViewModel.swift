//
//  NewsPageViewModel.swift
//  Evento
//
//  Created by Ramir Amrayev on 14.04.2023.
//

import Foundation
import Combine

final class NewsPageViewModel: ObservableObject {
    // MARK: - Callbacks
    var showArticle: Callback<Article>?
    
    @Published var articles: [Article] = []
    private let apiManager: NewsApiManagerProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(apiManager: NewsApiManagerProtocol) {
        self.apiManager = apiManager
        fetchArticles()
    }
    
    func fetchArticles() {
        apiManager.search(serchText: "Hello").sink(
            receiveCompletion: { completion in
                switch completion {
                case let .failure(error):
                    print(error)
                case .finished:
                    print("finished")
                }
            },
            receiveValue: { [weak self] response in
                self?.articles = response.articles
            }
        ).store(in: &cancellables)
    }
    
    func didTapArticle(article: Article) {
        showArticle?(article)
    }
}
