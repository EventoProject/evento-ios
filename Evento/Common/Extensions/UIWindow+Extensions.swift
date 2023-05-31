//
//  UIWindow+Extensions.swift
//  Evento
//
//  Created by Ramir Amrayev on 16.04.2023.
//

import UIKit

extension UIWindow {
    func getCurrentViewController() -> UIViewController? {
        guard let vc = self.rootViewController else { return nil }
        return getVCRecursive(vc)
    }

    func getCurrentTabBarController() -> UITabBarController? {
        if
            let navigationController = getCurrentNavigationConttroller(),
            let tabBarController = navigationController.viewControllers.first as? UITabBarController {
            return tabBarController
        }
        return nil
    }

    private func getCurrentNavigationConttroller() -> UINavigationController? {
        if let navigationController = self.rootViewController as? UINavigationController {
            return navigationController
        }
        return nil
    }

    private func getVCRecursive(_ vc: UIViewController) -> UIViewController? {
        if let pvc = vc.presentedViewController {
            return getVCRecursive(pvc)
        }
        if let svc = vc as? UISplitViewController, svc.viewControllers.count > 0 {
            return getVCRecursive(svc.viewControllers.last!)
        }
        if let nc = vc as? UINavigationController, nc.viewControllers.count > 0 {
            return getVCRecursive(nc.topViewController!)
        }
        if let tbc = vc as? UITabBarController {
            if let svc = tbc.selectedViewController {
                return getVCRecursive(svc)
            }
        }
        return vc
    }
}
