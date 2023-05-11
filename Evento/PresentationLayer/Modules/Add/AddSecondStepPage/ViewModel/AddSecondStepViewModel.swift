//
//  AddSecondStepViewModel.swift
//  Evento
//
//  Created by Ramir Amrayev on 09.05.2023.
//

import SwiftUI

final class AddSecondStepViewModel: ObservableObject {
    // MARK: - Callbacks
    var didTapContinue: VoidCallback?
    
    @Published var addFlowModel: AddFlowModel
    let categories: [String] = [
        "Business",
        "Sport",
        "Music",
        "Workshops",
        "Theatre"
    ]
    
    init(addFlowModel: AddFlowModel) {
        self.addFlowModel = addFlowModel
    }
    
    func didSelectCategory(category: String) {
        addFlowModel.selectedCategory = category
    }
}
