//
//  AddThirdStepViewModel.swift
//  Evento
//
//  Created by Ramir Amrayev on 13.05.2023.
//

import SwiftUI

private enum Constants {
    static let descriptionMinSymbolsCount = 100
}

final class AddThirdStepViewModel: ObservableObject {
    // MARK: - Callbacks
    var showNextStep: VoidCallback?
    
    // MARK: - Published parameters
    @Published var addFlowModel: AddFlowModel
    @Published var descriptionModel = InputViewModel()
    @Published var webSiteModel = InputViewModel()
    
    init(addFlowModel: AddFlowModel) {
        self.addFlowModel = addFlowModel
    }
    
    func didTapContinue() {
        guard isValid() else { return }
        showNextStep?()
    }
}

private extension AddThirdStepViewModel {
    // MARK: - Validation
    func isValid() -> Bool {
        var isValid = true
        isValid = isValidDescriptionModel() && isValid
        isValid = isValidModel(&webSiteModel) && isValid
        return isValid
    }
    
    func isValidModel(_ model: inout InputViewModel) -> Bool {
        if model.text.isEmpty {
            model.state = .error(text: "Required field")
            return false
        } else {
            return true
        }
    }
    
    func isValidDescriptionModel() -> Bool {
        guard isValidModel(&descriptionModel) else { return false }
        
        if descriptionModel.text.count < Constants.descriptionMinSymbolsCount {
            descriptionModel.state = .error(text: "The minimum number of is \(Constants.descriptionMinSymbolsCount)")
            return false
        } else {
            return true
        }
    }
}
