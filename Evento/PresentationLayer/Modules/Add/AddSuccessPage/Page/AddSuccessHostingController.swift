//
//  AddSuccessHostingController.swift
//  Evento
//
//  Created by Ramir Amrayev on 20.05.2023.
//

import SwiftUI

final class AddSuccessHostingController: UIHostingController<AddSuccessPage> {
    // MARK: - Callbacks
    var isParentNavBarHidden: Callback<Bool>?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        isParentNavBarHidden?(true)
        // Hide the navigation bar
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        isParentNavBarHidden?(false)
        // Show the navigation bar
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}
