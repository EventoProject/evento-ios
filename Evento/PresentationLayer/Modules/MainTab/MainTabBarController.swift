//
//  MainTabBarController.swift
//  Evento
//
//  Created by Ramir Amrayev on 01.05.2023.
//

import UIKit

enum TabBarList: Int {
    case events = 0
    case favorites
    case add
    case chat
    case profile
}

final class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    private let injection: CustInjection
    private var eventsCoordinator: EventsModuleCoordinator?
    private var favoritesCoordinator: FavoritesModuleCoordinator?
    private var addCoordinator: AddModuleCoordinator?
    private var chatCoordinator: ChatModuleCoordinator?
    private var profileCoordinator: ProfileModuleCoordinator?

    private var tabBarNavigationControllers = [UINavigationController]()
    private let customTabBar = RoundedTabBar()
    private lazy var router = injection.inject(Router.self)
    
    init(injection: CustInjection) {
        self.injection = injection
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()

        makeAllModules()
    }
}

private extension MainTabBarController {
    func makeAllModules() {
        tabBarNavigationControllers = []
        makeEventsModule()
        makeFavoritesModule()
        makeAddModule()
        makeChatModule()
        makeProfileModule()

        viewControllers = tabBarNavigationControllers
    }
    
    func makeEventsModule() {
        let navigationController = BaseNavigationController()
        eventsCoordinator = EventsModuleCoordinator(
            injection: injection,
            router: router,
            navigationController: navigationController
        )
        eventsCoordinator?.start()
        navigationController.tabBarItem = UITabBarItem(
            title: "Events",
            image: Images.eventsTabItem,
            tag: 0
        )
        navigationController.tabBarItem.selectedImage = Images.eventsTabItemSelected
        tabBarNavigationControllers.append(navigationController)
    }
    
    func makeFavoritesModule() {
        let navigationController = BaseNavigationController()
        favoritesCoordinator = FavoritesModuleCoordinator(
            injection: injection,
            router: router,
            navigationController: navigationController
        )
        favoritesCoordinator?.start()
        navigationController.tabBarItem = UITabBarItem(
            title: "Favorites",
            image: Images.favoritesTabItem,
            tag: 0
        )
        navigationController.tabBarItem.selectedImage = Images.favoritesTabItemSelected
        tabBarNavigationControllers.append(navigationController)
    }
    
    func makeAddModule() {
        let navigationController = BaseNavigationController()
        addCoordinator = AddModuleCoordinator(
            injection: injection,
            router: router,
            navigationController: navigationController
        )
        addCoordinator?.start()
        navigationController.tabBarItem = UITabBarItem(
            title: "Add",
            image: Images.addTabItem,
            tag: 0)
        navigationController.tabBarItem.selectedImage = Images.addTabItemSelected
        tabBarNavigationControllers.append(navigationController)
    }
    
    func makeChatModule() {
        let navigationController = BaseNavigationController()
        chatCoordinator = ChatModuleCoordinator(
            injection: injection,
            router: router,
            navigationController: navigationController
        )
        chatCoordinator?.start()
        navigationController.tabBarItem = UITabBarItem(
            title: "Chat",
            image: Images.chatTabItem,
            tag: 0
        )
        navigationController.tabBarItem.selectedImage = Images.chatTabItemSelected
        tabBarNavigationControllers.append(navigationController)
    }
    
    func makeProfileModule() {
        let navigationController = BaseNavigationController()
        profileCoordinator = ProfileModuleCoordinator(
            injection: injection,
            router: router,
            navigationController: navigationController
        )
        profileCoordinator?.start()
        navigationController.tabBarItem = UITabBarItem(
            title: "Profile",
            image: Images.profileTabItem,
            tag: 0
        )
        navigationController.tabBarItem.selectedImage = Images.profileTabItemSelected
        tabBarNavigationControllers.append(navigationController)
    }
    
    func setupTabBar() {
        setValue(customTabBar, forKey: "tabBar")
        tabBar.tintColor = UIColor(red: 94/256, green: 89/256, blue: 220/256, alpha: 1)
        tabBar.unselectedItemTintColor = .gray
        tabBar.isTranslucent = false
        view.backgroundColor = .white
    }
    
    func getCoordinator(index: Int) -> BaseCoordinator? {
        guard let tabBarList = TabBarList(rawValue: index) else { return nil }
        switch tabBarList {
        case .events:
            return eventsCoordinator
        case .favorites:
            return favoritesCoordinator
        case .add:
            return addCoordinator
        case .chat:
            return chatCoordinator
        case .profile:
            return profileCoordinator
        }
    }

    final class RoundedTabBar: UITabBar {
        private var shapeLayer: CALayer?
        
        override func draw(_ rect: CGRect) {
            self.addShape()
        }
        
        private func addShape() {
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = UIBezierPath(
                roundedRect: bounds,
                byRoundingCorners: [.topLeft, .topRight],
                cornerRadii: CGSize(width: 15, height: 15)).cgPath
            shapeLayer.fillColor = UIColor.white.cgColor
            
            if let oldShapeLayer = self.shapeLayer {
                layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
            } else {
                layer.insertSublayer(shapeLayer, at: 0)
            }
            self.shapeLayer = shapeLayer
        }
    }
}
