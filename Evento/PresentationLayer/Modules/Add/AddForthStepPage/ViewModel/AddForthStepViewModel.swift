//
//  AddForthStepViewModel.swift
//  Evento
//
//  Created by Ramir Amrayev on 13.05.2023.
//

import SwiftUI

final class AddForthStepViewModel: ObservableObject {
    // MARK: - Callbacks
    var didTapPublishEvent: VoidCallback?
    
    @Published var addFlowModel: AddFlowModel
    @Published var selectedFormat: String?
    @Published var priceModel = InputViewModel()
    @Published var locationModel = InputViewModel()
    @Published var isLoadingButton = false
    let formats = ["Offline", "Online"]
    
    init(addFlowModel: AddFlowModel) {
        self.addFlowModel = addFlowModel
    }
    
    func didSelectFormat(format: String) {
        selectedFormat = format
    }
}
