//
//  GeneralViemModel.swift
//  Evento
//
//  Created by RAmrayev on 28.05.2023.
//

import Foundation
import SwiftUI

final class GeneralViemModel: ObservableObject {
    var didTapLogOut: VoidCallback?
    // MARK: - Callbacks
    let categories: [String] = [
        "Privacy policy",
        "Terms of use",
        "About the app"
    ]
}
