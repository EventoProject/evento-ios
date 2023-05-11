//
//  AddCoordinator.swift
//  Evento
//
//  Created by Ramir Amrayev on 06.05.2023.
//

import UIKit
import SwiftUI

final class AddCoordinator: BaseCoordinator {
    init(injection: CustInjection, router: Router, navigationController: UINavigationController) {
        super.init(injection: injection, router: router)
        router.set(navigationController: navigationController)
    }
    
    func start() {
        showFirstStepPage()
    }
}

private extension AddCoordinator {
    func showFirstStepPage() {
        let viewModel = AddFirstStepViewModel()
        
        viewModel.didTapPickImage = { [weak self] didPickImage in
            self?.showImagePickerPage(didPickImage: didPickImage)
        }
        
        viewModel.didTapContinue = { [weak self, weak viewModel] in
            guard let viewModel else { return }
            self?.showSecondStepPage(addFlowModel: viewModel.addFlowModel)
        }
        
        let page = UIHostingController(rootView: AddFirstStepPage(viewModel: viewModel))
        router.set(viewControllers: [page], animated: true)
    }
    
    func showImagePickerPage(didPickImage: Callback<UIImage?>?) {
        let page = ImagePickerPage()
        page.didPickImage = didPickImage
        router.present(page, animated: true, completion: nil)
    }
    
    func showSecondStepPage(addFlowModel: AddFlowModel) {
        let viewModel = AddSecondStepViewModel(addFlowModel: addFlowModel)
        
        viewModel.didTapContinue = { [weak self, weak viewModel] in
            guard let viewModel else { return }
            self?.showThirdStepPage(addFlowModel: viewModel.addFlowModel)
        }
        
        let page = UIHostingController(rootView: AddSecondStepPage(viewModel: viewModel))
        router.push(viewController: page, animated: true)
    }
    
    func showThirdStepPage(addFlowModel: AddFlowModel) {
        let viewModel = AddThirdStepViewModel(addFlowModel: addFlowModel)
        let page = UIHostingController(rootView: AddThirdStepPage(viewModel: viewModel))
        router.push(viewController: page, animated: true)
    }
}
