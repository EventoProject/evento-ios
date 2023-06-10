//
//  ChatsViewModel.swift
//  Evento
//
//  Created by Ramir Amrayev on 10.06.2023.
//

import Foundation
import Combine

final class ChatsViewModel: ObservableObject {
    // MARK: - Callbacks
    var showChatPage: Callback<ChatsResponseItemModel>?
    
    // MARK: - Published parameters
    @Published var chats: [ChatsResponseItemModel] = []
    
    // MARK: - Private parameters
    private let apiManager: ChatApiManagerProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(apiManager: ChatApiManagerProtocol) {
        self.apiManager = apiManager
        
        getChats()
    }
    
    func didTap(chat: ChatsResponseItemModel) {
        showChatPage?(chat)
    }
    
    func refresh() {
        getChats()
    }
    
    private func getChats() {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.apiManager.getChats().sink(
                receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        print(error)
                    }
                },
                receiveValue: { [weak self] model in
                    self?.chats = model
                }
            ).store(in: &self.cancellables)
        }
    }
}
