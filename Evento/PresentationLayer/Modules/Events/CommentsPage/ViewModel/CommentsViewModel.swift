//
//  CommentsViewModel.swift
//  Evento
//
//  Created by Ramir Amrayev on 31.05.2023.
//

import SwiftUI
import Combine

private enum Constants {
    static let avatarImageUrlKey = "avatarImageUrlKey"
}

final class CommentsViewModel: ObservableObject {
    // MARK: - Published parameters
    @Published var comments: [CommentItemModel] = []
    @Published var isAlertPresented = false
    @Published var commentModel = InputViewModel()
    
    // MARK: - Public parameters
    var alertMainText = ""
    let avatarImageUrl = UserDefaults.standard.string(forKey: Constants.avatarImageUrlKey) ?? ""
    lazy var userId: Int? = {
        if
            let userIdString = keychainManager.getString(type: .userId),
            let userId = Int(userIdString) {
            return userId
        } else {
            return nil
        }
    }()
    
    // - MARK: Private parameters
    private let eventId: Int
    private let apiManager: EventsApiManagerProtocol
    private let keychainManager: KeychainManagerProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(eventId: Int, apiManager: EventsApiManagerProtocol, keychainManager: KeychainManagerProtocol) {
        self.eventId = eventId
        self.apiManager = apiManager
        self.keychainManager = keychainManager
        
        getComments()
    }
    
    func didTapReply(_ comment: CommentItemModel) {
        print("Reply \(comment.content) comment")
    }
    
    func didTapSendComment() {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.apiManager.sendComment(
                text: self.commentModel.text,
                eventId: self.eventId
            ).sink(
                receiveCompletion: { [weak self] completion in
                    if case let .failure(error) = completion {
                        self?.showAlert(mainText: error.localizedDescription)
                    }
                },
                receiveValue: { [weak self] _ in
                    self?.showAlert(
                        mainText: "Your comment  successfully sended",
                        messageText: "You can see it if you tap on comments link"
                    )
                    self?.commentModel.text = ""
                    self?.getComments()
                }
            ).store(in: &self.cancellables)
        }
    }
    
    func didTapDelete(at offsets: IndexSet) {
        guard let index = offsets.first else { return }
        let comment = comments[index]
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.apiManager.deleteComment(commentId: comment.commentId).sink(
                receiveCompletion: { [weak self] completion in
                    if case let .failure(error) = completion {
                        self?.showAlert(mainText: error.localizedDescription)
                        self?.getComments()
                    }
                },
                receiveValue: { _ in
                    print("Successfully deleted comment \(comment.content)")
                }
            ).store(in: &self.cancellables)
        }
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
                receiveValue: { [weak self] response in
                    self?.comments = response
                }
            ).store(in: &self.cancellables)
        }
    }
    
    func showAlert(mainText: String, messageText: String = "") {
        alertMainText = mainText
        isAlertPresented = true
    }
}
