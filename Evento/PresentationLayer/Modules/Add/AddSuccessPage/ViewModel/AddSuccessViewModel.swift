//
//  AddSuccessViewModel.swift
//  Evento
//
//  Created by Ramir Amrayev on 20.05.2023.
//

import SwiftUI

final class AddSuccessViewModel: ObservableObject {
    // MARK: - Callbacks
    var openEventsModule: VoidCallback?
    var showFirstStep: VoidCallback?
    
    func didTapBackToEventsButton() {
        openEventsModule?()
    }
}
