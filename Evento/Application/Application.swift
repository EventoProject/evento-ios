//
//  Application.swift
//  Evento
//
//  Created by Ramir Amrayev on 16.04.2023.
//

import UIKit

final class Application {
    static let shared = Application()
    
    func presentInitialScreen(in window: UIWindow?) {
        guard let window = window else { return }
        
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        
        let appCoordinator = AppCoordinator(navigationController: navigationController)
        
        appCoordinator.start()
        window.makeKeyAndVisible()
    }
}
