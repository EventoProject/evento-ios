//
//  CustInject.swift
//  Evento
//
//  Created by Ramir Amrayev on 02.05.2023.
//

import Swinject

extension Container {
    /// Builder method to register Foundation and UIKit dependencies
    
    /// Builder method to register App service protocols in container
    ///
    /// - Returns: Container itself for further building
    func registerAppServices() -> Self {
        registerNonApiManagers()
        
        // register api managers
        register(NewsApiManagerProtocol.self) { res in
            NewsApiManager(webService: res.resolve(WebServiceProtocol.self)!)
        }
        
        register(OnboardingApiManagerProtocol.self) { res in
            OnboardingApiManager(webService: res.resolve(WebServiceProtocol.self)!)
        }
        
        register(ProfileApiManagerProtocol.self) { res in
            ProfileApiManager(webService: res.resolve(WebServiceProtocol.self)!)
        }
        
        register(AddApiManagerProtocol.self) { res in
            AddApiManager(webService: res.resolve(WebServiceProtocol.self)!)
        }
        
        register(EventsApiManagerProtocol.self) { res in
            EventsApiManager(webService: res.resolve(WebServiceProtocol.self)!)
        }
        
        register(ChatApiManagerProtocol.self) { res in
            ChatApiManager(webService: res.resolve(WebServiceProtocol.self)!)
        }
        
        register(WebSocketManagerProtocol.self) { res in
            WebSocketManager()
        }
        
        return self
    }
    
    private func registerNonApiManagers() {
        register(Router.self) { _ in
            MainRouter()
        }
        
        register(KeychainManagerProtocol.self) { res in
            KeychainManager()
        }
        
        register(WebServiceProtocol.self) { res in
            WebService(keychainManager: res.resolve(KeychainManagerProtocol.self)!)
        }.inObjectScope(.container)
    }
    
    /// Builder method to register App Factory protocols in container
    ///
    /// - Returns: Container itself for further building
    func registerAppFactories() -> Self {
        return self
    }
}

extension Container: CustInjection {
    func inject<Dependency>(_ serviceType: Dependency.Type) -> Dependency {
        guard let dependency = resolve(serviceType) else {
            fatalError("You does't register \(Dependency.Type.self) service")
        }
        return dependency
    }
    
    func reset(_ objectScope: ObjectScope) {
        resetObjectScope(objectScope)
    }
}

/// Globally used enum that holds a main dependency container and also container-computing properties.
/// NOTE: Make sure to register all dependencies in CustInject container and create static variable
enum CustInject {
    enum InjectionMode {
        case standard
        case stubbed
    }

    static var mode: InjectionMode = .standard {
        didSet {
            switch mode {
            case .standard:
                depContainer = CustInject.buildDefaulContainer()
            case .stubbed:
                depContainer = CustInject.stubContainer
            }
        }
    }

    static var depContainer: Container = CustInject.buildDefaulContainer()

    /// Computed dependency container with prod classes registered
    private static func buildDefaulContainer() -> Container {
        let container = Container(defaultObjectScope: .transient)
        return container
            .registerAppServices()
    }

    /// This predefined dep container is used when API is not available, or in testing
    private static var stubContainer: Container {
        let container = CustInject.buildDefaulContainer()
        return container
    }
}
