//
//  AddFirstStepViewModel.swift
//  Evento
//
//  Created by Ramir Amrayev on 08.05.2023.
//

import SwiftUI

struct AddFlowModel {
    var eventName = ""
    var posterImage: UIImage?
    var selectedCategory: String?
    var description = ""
    var webSiteLink = ""
    var priceText = ""
    var selectedDate = ""
    var location = ""
}

final class AddFirstStepViewModel: ObservableObject {
    // MARK: - Callbacks
    var didTapPickImage: Callback<Callback<UIImage?>>?
    var didTapContinue: VoidCallback?
    
    @Published var addFlowModel = AddFlowModel()
    @Published var eventNameModel = InputViewModel()
    @Published var isLoadingButton = false
    
    func didTapUploadPoster() {
        didTapPickImage?() { [weak self] selectedImage in
            self?.addFlowModel.posterImage = selectedImage
        }
    }
}
