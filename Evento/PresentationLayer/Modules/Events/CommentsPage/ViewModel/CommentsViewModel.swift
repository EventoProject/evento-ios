//
//  CommentsViewModel.swift
//  Evento
//
//  Created by Ramir Amrayev on 31.05.2023.
//

import SwiftUI
import Combine

final class CommentsViewModel: ObservableObject {
    // MARK: - Published parameters
    @Published var comments: [CommentItemModel] = []
    @Published var isAlertPresented = false
    @Published var commentModel = InputViewModel()
    
    // MARK: - Public parameters
    var alertMainText = ""
    
    // - MARK: Private parameters
    private let eventId: Int
    private let apiManager: EventsApiManagerProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(eventId: Int, apiManager: EventsApiManagerProtocol) {
        self.eventId = eventId
        self.apiManager = apiManager
        
        getComments()
    }
    
    func didTapReply(_ comment: CommentItemModel) {
        print("Reply \(comment.content) comment")
    }
}

private extension CommentsViewModel {
    func getComments() {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.apiManager.getComments(eventId: self.eventId).sink(
                receiveCompletion: { [weak self] completion in
                    if case let .failure(error) = completion {
                        self?.showAlert(mainText: error.localizedDescription)
                    }
                },
                receiveValue: { [weak self] model in
                    self?.comments = model.comments
                }
            ).store(in: &self.cancellables)
        }
    }
    
    func showAlert(mainText: String, messageText: String = "") {
        alertMainText = mainText
        isAlertPresented = true
    }
}
