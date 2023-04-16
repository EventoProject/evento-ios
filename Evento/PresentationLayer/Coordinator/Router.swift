//
//  Router.swift
//  Evento
//
//  Created by Ramir Amrayev on 16.04.2023.
//

import UIKit

protocol Router {
    func set(navigationController: UINavigationController)
    func getNavigationController() -> UINavigationController
    func getTabBarController() -> UITabBarController?
    func getTopViewController() -> UIViewController?
    func push(viewController: UIViewController, animated: Bool)
    func push(viewController: UIViewController, animated: Bool, poppingToRootViewController: Bool)
    func push(viewController: UIViewController, prefersLargeTitle: Bool, hideBottomBar: Bool, animated: Bool)
    func push(viewController: UIViewController, animated: Bool, hideBottomBar: Bool)
    func push(
        viewController: UIViewController,
        animated: Bool,
        onFinish: VoidCallback?
    )
    func pop(animated: Bool)
    func popToRootViewController(animated: Bool)
    func pop(to viewController: UIViewController, animated: Bool)
    func present(_ viewController: UIViewController, animated: Bool, completion: VoidCallback?)
    func dismiss(animated: Bool, completion: VoidCallback?)
    func reattach()
    func set(viewControllers: [UIViewController], animated: Bool)
}

final class MainRouter: NSObject, Router {
    var navigationController: UINavigationController = .init()
    private var completions = [UIViewController: VoidCallback]()

    func set(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.delegate = self
    }

    func getNavigationController() -> UINavigationController {
        return navigationController
    }

    func getTabBarController() -> UITabBarController? {
        guard let window = UIApplication.shared.delegate?.window,
            let tabBarController = window?.getCurrentTabBarController() else { return nil }
        return tabBarController
    }

    func getTopViewController() -> UIViewController? {
        let keyWindow = UIApplication.shared.windows.first { $0.isKeyWindow }

        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
    }
    func push(viewController: UIViewController, animated: Bool) {
        push(viewController: viewController, animated: animated, onFinish: nil)
    }

    func push(
        viewController: UIViewController,
        animated: Bool,
        onFinish: VoidCallback? = nil
    ) {
        navigationController.pushViewController(viewController, animated: animated)
        if let onFinish = onFinish {
            completions[viewController] = onFinish
        }
    }
    
    func push(
        viewController: UIViewController,
        animated: Bool,
        completion: (() -> Void)?
    ) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        push(viewController: viewController, animated: animated)
        CATransaction.commit()
    }

    func push(viewController: UIViewController, animated: Bool, poppingToRootViewController: Bool) {
        if !poppingToRootViewController {
            push(viewController: viewController, animated: animated)
            return
        }
        guard let rootViewController = navigationController.viewControllers.first else { return }
        set(viewControllers: [rootViewController, viewController], animated: animated)
    }

    func push(viewController: UIViewController, prefersLargeTitle: Bool, hideBottomBar: Bool, animated: Bool) {
        if prefersLargeTitle {
            navigationController.navigationBar.prefersLargeTitles = true
            navigationController.navigationItem.largeTitleDisplayMode = .automatic
        } else {
            navigationController.navigationItem.largeTitleDisplayMode = .never
        }

        viewController.hidesBottomBarWhenPushed = hideBottomBar
        navigationController.pushViewController(viewController, animated: animated)
    }

    func push(viewController: UIViewController, animated: Bool, hideBottomBar: Bool) {
        viewController.hidesBottomBarWhenPushed = hideBottomBar
        navigationController.pushViewController(viewController, animated: animated)
    }

    func pop(animated: Bool) {
        if let controller = navigationController.popViewController(animated: animated) {
            runCompletion(for: controller)
        }
    }

    func popToRootViewController(animated: Bool) {
        if let controllers = navigationController.popToRootViewController(animated: animated) {
            controllers.forEach { runCompletion(for: $0) }
        }
    }

    func pop(to viewController: UIViewController, animated: Bool) {
        navigationController.popToViewController(viewController, animated: animated)
    }

    func present(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        navigationController.present(viewController, animated: animated, completion: completion)
    }

    func dismiss(animated: Bool, completion: (() -> Void)? = nil) {
        navigationController.dismiss(animated: true, completion: completion)
    }

    func reattach() {
        navigationController.delegate = self
    }

    func set(viewControllers: [UIViewController], animated: Bool) {
        navigationController.setViewControllers(viewControllers, animated: animated)
    }
    
    private func runCompletion(for controller: UIViewController) {
        guard let completion = completions[controller] else { return }
        completion()
        completions.removeValue(forKey: controller)
    }
}

extension MainRouter: UINavigationControllerDelegate {
    public func navigationController(
        _ navigationController: UINavigationController,
        didShow viewController: UIViewController,
        animated: Bool
    ) {
        guard
            let poppedViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
            !navigationController.viewControllers.contains(poppedViewController)
        else {
            return
        }
        runCompletion(for: poppedViewController)
    }
}

