//
//  Application.swift
//  Evento
//
//  Created by Ramir Amrayev on 16.04.2023.
//

import UIKit

private enum Constants: String {
    case isFirstLaunch
}

final class Application {
    static let shared = Application()
    
    // MARK: - Private parameters
    private var appCoordinator: AppCoordinator?
    private let injection: CustInjection = CustInject.depContainer
    
    private lazy var keychainManager: KeychainManagerProtocol = {
        injection.inject(KeychainManagerProtocol.self)
    }()
    
    private init() {
        checkForFirstLaunch()
    }
    
    func presentInitialScreen(in window: UIWindow?) {
        guard let window = window else { return }
        
        let navigationController = BaseNavigationController()
        window.rootViewController = navigationController
        
        appCoordinator = AppCoordinator(navigationController: navigationController, injection: injection)
        
        appCoordinator?.start()
        window.makeKeyAndVisible()
    }
    
    func reauthorize() {
        // TODO: change rm with DI
        injection.inject(WebServiceProtocol.self).flushToken()
        appCoordinator?.reauthorize()
    }
}

private extension Application {
    func checkForFirstLaunch() {
        // TODO: Need user storage
        let defaults = UserDefaults.standard

        if !defaults.bool(forKey: Constants.isFirstLaunch.rawValue) {
            defaults.set(true, forKey: Constants.isFirstLaunch.rawValue)
            UserDefaults.standard.set(true, forKey: Constants.isFirstLaunch.rawValue)
            clearSecureStorage()
        }
    }
    
    func clearSecureStorage() {
        keychainManager.deleteAll()
    }
}
