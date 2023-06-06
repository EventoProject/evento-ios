//
//  AddSuccessViewModel.swift
//  Evento
//
//  Created by Ramir Amrayev on 20.05.2023.
//

import SwiftUI

final class AddSuccessViewModel: ObservableObject {
    // MARK: - Callbacks
    var buttonTapped: VoidCallback?
    var onDisappear: VoidCallback?
    
    // MARK: - Public parameters
    let title: String
    let subtitle: String
    let buttonTitle: String
    
    init(title: String, subtitle: String, buttonTitle: String) {
        self.title = title
        self.subtitle = subtitle
        self.buttonTitle = buttonTitle
    }
    
    func didTapButton() {
        buttonTapped?()
    }
}
