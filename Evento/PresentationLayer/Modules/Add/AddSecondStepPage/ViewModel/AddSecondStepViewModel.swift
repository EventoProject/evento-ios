//
//  AddSecondStepViewModel.swift
//  Evento
//
//  Created by Ramir Amrayev on 09.05.2023.
//

import SwiftUI
import Combine

final class AddSecondStepViewModel: ObservableObject {
    // MARK: - Callbacks
    var showNextStep: VoidCallback?
    
    // MARK: - Published parameters
    @Published var addFlowModel: AddFlowModel
    @Published var isLoading = false
    @Published var categories: [CategoryModel] = []
    
    // MARK: - Private parameters
    private let apiManager: AddApiManagerProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(addFlowModel: AddFlowModel, apiManager: AddApiManagerProtocol) {
        self.addFlowModel = addFlowModel
        self.apiManager = apiManager
        
        getCategories()
    }
    
    func didSelectCategory(category: CategoryModel) {
        addFlowModel.selectedCategory = category
        showNextStep?()
    }
    
    private func getCategories() {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.apiManager.getCategories().sink(
                receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        print(error)
                    }
                },
                receiveValue: { [weak self] model in
                    self?.categories = model.categories
                }
            ).store(in: &self.cancellables)
        }
    }
}
