//
//  FilterViewModel.swift
//  Evento
//
//  Created by Ramir Amrayev on 27.05.2023.
//

import SwiftUI
import Combine

final class FilterViewModel: ObservableObject {
    // MARK: - Published parameters
    @Published var menuCategories: [String] = ["All"]
    @Published var selectedCategoryMenuItem = "All"
    
    let menuFormats: [String] = ["All", "Offline", "Online"]
    @Published var selectedFormatMenuItem = "All"
    
    let menuAgeLimits: [String] = [
        "All",
        "0+",
        "3+",
        "6+",
        "12+",
        "16+",
        "18+",
        "21+"
    ]
    @Published var selectedAgeLimitMenuItem = "All"
    
    @Published var fromPriceInputModel = InputViewModel()
    @Published var toPriceInputModel = InputViewModel()
    
    @Published var fromDate = Date()
    @Published var toDate = Date()
    
    // MARK: - Private parameters
    private let apiManager: AddApiManagerProtocol
    private var cancellables = Set<AnyCancellable>()
    private var categories: [CategoryModel] = []
    
    private var selectedCategory: CategoryModel? {
        guard let selectedMenuItemIndex = menuCategories.firstIndex(of: selectedCategoryMenuItem)
        else {
            return nil
        }
        if selectedMenuItemIndex == 0 {
            return nil
        } else {
            return categories[selectedMenuItemIndex - 1]
        }
    }
    
    private var selectedFormat: String? {
        selectedFormatMenuItem == "All" ? nil : selectedFormatMenuItem
    }
    
    private var selectedAgeLimit: String? {
        selectedAgeLimitMenuItem == "All" ? nil : selectedAgeLimitMenuItem
    }
    
    private var searchBarText: String?
    
    init(apiManager: AddApiManagerProtocol) {
        self.apiManager = apiManager
        
        getCategories()
    }
    
    func didTapApplyFilters() {
        print(selectedCategory)
        print(selectedFormat)
        print(selectedAgeLimit)
        print(fromPriceInputModel.text)
        print(toPriceInputModel.text)
        print(fromDate)
        print(toDate)
    }
    
    func searchBarTextChanged(_ text: String) {
        searchBarText = text
    }
    
    func didTapSearch() {
        // Handle search action
        print("Search button tapped")
    }
}

private extension FilterViewModel {
    func getCategories() {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.apiManager.getCategories().sink(
                receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        print(error)
                    }
                },
                receiveValue: { [weak self] model in
                    let categories = model.categories
                    self?.categories = categories
                    self?.menuCategories.append(contentsOf: categories.map { $0.name })
                }
            ).store(in: &self.cancellables)
        }
    }
}
