//
//  AddThirdStepViewModel.swift
//  Evento
//
//  Created by Ramir Amrayev on 13.05.2023.
//

import SwiftUI

final class AddThirdStepViewModel: ObservableObject {
    // MARK: - Callbacks
    var didTapContinue: VoidCallback?
    
    @Published var addFlowModel: AddFlowModel
    @Published var webSiteModel = InputViewModel()
    @Published var isLoadingContinue = false
    
    init(addFlowModel: AddFlowModel) {
        self.addFlowModel = addFlowModel
    }
}
