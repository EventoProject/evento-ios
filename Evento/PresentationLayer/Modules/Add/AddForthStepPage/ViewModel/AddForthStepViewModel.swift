//
//  AddForthStepViewModel.swift
//  Evento
//
//  Created by Ramir Amrayev on 13.05.2023.
//

import SwiftUI
import Combine

final class AddForthStepViewModel: ObservableObject {
    // MARK: - Callbacks
    var showSuccessPage: VoidCallback?
    
    // MARK: - Published parameters
    @Published var addFlowModel: AddFlowModel
    @Published var selectedFormatModel = InputViewModel()
    @Published var priceModel = InputViewModel()
    @Published var addressModel = InputViewModel()
    @Published var isLoadingButton = false
    
    // MARK: - Public parameters
    let formats = ["Offline", "Online"]
    
    // MARK: - Private parameters
    private let apiManager: AddApiManagerProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(addFlowModel: AddFlowModel, apiManager: AddApiManagerProtocol) {
        self.addFlowModel = addFlowModel
        self.apiManager = apiManager
    }
    
    func didSelectFormat(format: String) {
        selectedFormatModel.text = format
    }
    
    func didTapPublishEvent() {
        guard isValid() else { return }
        createEvent()
    }
}

private extension AddForthStepViewModel {
    // MARK: - Validation
    func isValid() -> Bool {
        var isValid = true
        isValid = isValidSelectedFormat() && isValid
        isValid = isValidModel(&addressModel) && isValid
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
    
    func isValidSelectedFormat() -> Bool {
        if selectedFormatModel.text.isEmpty {
            selectedFormatModel.state = .error(text: "Need to choose")
            return false
        } else {
            return true
        }
    }
    
    // MARK: - Api methods
    func createEvent() {
        guard let imageBase64 = addFlowModel.image?.toBase64String() else { return }
        
        let payload = CreateEventPayload(
            name: addFlowModel.eventName,
            description: addFlowModel.description,
            format: addFlowModel.format,
            cost: "Free",
            date: addFlowModel.selectedDate,
            duration: "2 hours",
            ageLimit: "16+",
            imageBase64: imageBase64
        )
        
        isLoadingButton = true
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.apiManager.createEvent(payload).sink(
                receiveCompletion: { [weak self] completion in
                    if case let .failure(error) = completion {
                        print(error)
                    }
                    self?.isLoadingButton = false
                },
                receiveValue: { [weak self] model in
                    self?.showSuccessPage?()
                }
            ).store(in: &self.cancellables)
        }
    }
}
