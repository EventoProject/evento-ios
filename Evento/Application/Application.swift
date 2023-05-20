//
//  Application.swift
//  Evento
//
//  Created by Ramir Amrayev on 16.04.2023.
//

import UIKit

final class Application {
    static let shared = Application()
    
    private var appCoordinator: AppCoordinator?
    private let injection: CustInjection = CustInject.depContainer
    
    func presentInitialScreen(in window: UIWindow?) {
        guard let window = window else { return }
        
        let navigationController = BaseNavigationController()
        window.rootViewController = navigationController
        
        appCoordinator = AppCoordinator(navigationController: navigationController, injection: injection)
        
        appCoordinator?.start()
        window.makeKeyAndVisible()
    }
}
