//
//  SearchViewModel.swift
//  Evento
//
//  Created by RAmrayev on 10.06.2023.
//

import Foundation
import SwiftUI
import Combine


final class SearchViewModel: ObservableObject{
    
    private let apiManager: ProfileApiManagerProtocol
    private var cancellables = Set<AnyCancellable>()
    @Published var users: [SearchUserModel] = []
    @Published var searchText: String = ""
    var showUserProfile: Callback<Int>?

    init(apiManager: ProfileApiManagerProtocol){
        self.apiManager = apiManager
        self.getUsers()
    }
    func ShowUserProfile(id: Int){
        showUserProfile?(id)
    }
    private func getUsers() {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.apiManager.getUsers().sink(
                receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        print(error)
                    }
                },
                receiveValue: { [weak self] model in
                    self?.users = model.users
                }
            ).store(in: &self.cancellables)
        }
    }
}
