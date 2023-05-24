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
    var selectedCategory: CategoryModel?
    var description = ""
    var webSiteLink = ""
    var priceText = ""
    var selectedDate = ""
    var fullAddress = ""
    var format = ""
    var image: UIImage?
}

struct ImageModel: Hashable {
    var image: UIImage?
    var state: InputViewState = .default
}

final class AddFirstStepViewModel: ObservableObject {
    // MARK: - Callbacks
    var didTapPickImage: Callback<Callback<UIImage?>>?
    var showNextStep: VoidCallback?
    
    @Published var addFlowModel = AddFlowModel()
    @Published var eventNameModel = InputViewModel()
    @Published var imageModel = ImageModel()
    
    func didTapUploadPoster() {
        didTapPickImage?() { [weak self] selectedImage in
            self?.addFlowModel.posterImage = selectedImage
            self?.imageModel.image = selectedImage
        }
    }
    
    func didTapContinue() {
        guard isValid() else { return }
        showNextStep?()
    }
}

private extension AddFirstStepViewModel {
    func isValid() -> Bool {
        var isValid = true
        isValid = isValidModel(&eventNameModel) && isValid
        isValid = isValidImageModel() && isValid
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
    
    func isValidImageModel() -> Bool {
        if imageModel.image == nil {
            imageModel.state = .error(text: "Required field")
            return false
        } else {
            return true
        }
    }
}
