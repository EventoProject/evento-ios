//
//  AddCoordinator.swift
//  Evento
//
//  Created by Ramir Amrayev on 06.05.2023.
//

import UIKit
import SwiftUI

final class AddCoordinator: BaseCoordinator {
    // MARK: - Callbacks
    var isParentNavBarHidden: Callback<Bool>?
    var openEventsModule: VoidCallback?
    
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
        
        viewModel.showNextStep = { [weak self, weak viewModel] in
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
        let viewModel = AddSecondStepViewModel(
            addFlowModel: addFlowModel,
            apiManager: injection.inject(AddApiManagerProtocol.self)
        )
        
        viewModel.showNextStep = { [weak self, weak viewModel] in
            guard let viewModel else { return }
            self?.showThirdStepPage(addFlowModel: viewModel.addFlowModel)
        }
        
        let page = UIHostingController(rootView: AddSecondStepPage(viewModel: viewModel))
        router.push(viewController: page, animated: true)
    }
    
    func showThirdStepPage(addFlowModel: AddFlowModel) {
        let viewModel = AddThirdStepViewModel(addFlowModel: addFlowModel)
        
        viewModel.showNextStep = { [weak self] in
            self?.showForthStepPage(addFlowModel: viewModel.addFlowModel)
        }
        
        let page = UIHostingController(rootView: AddThirdStepPage(viewModel: viewModel))
        router.push(viewController: page, animated: true)
    }
    
    func showForthStepPage(addFlowModel: AddFlowModel) {
        let viewModel = AddForthStepViewModel(
            addFlowModel: addFlowModel,
            apiManager: injection.inject(AddApiManagerProtocol.self)
        )
        
        viewModel.showSuccessPage = { [weak self] in
            self?.showSuccessPage()
        }
        
        let page = UIHostingController(rootView: AddForthStepPage(viewModel: viewModel))
        router.push(viewController: page, animated: true)
    }
    
    func showSuccessPage() {
        let viewModel = AddSuccessViewModel()
        
        viewModel.openEventsModule = { [weak self] in
            self?.openEventsModule?()
        }
        
        viewModel.showFirstStep = { [weak self] in
            self?.showFirstStepPage()
        }
        
        let page = AddSuccessHostingController(rootView: AddSuccessPage(viewModel: viewModel))
        page.isParentNavBarHidden = isParentNavBarHidden
        router.push(viewController: page, animated: true)
    }
}
