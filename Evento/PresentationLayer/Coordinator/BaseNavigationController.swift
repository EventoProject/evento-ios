//
//  BaseNavigationController.swift
//  Evento
//
//  Created by Ramir Amrayev on 18.04.2023.
//

import UIKit

private enum Constants {
    static let navigationBarTitleSize: CGFloat = 14
    static let titleFont = MontserratFont.createUIFont(weight: .semiBold, size: 23)
    static let titleAttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: UIColor.black,
        .font: titleFont
    ]
}

class BaseNavigationController: UINavigationController {
    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        navigationBar.prefersLargeTitles = true
        navigationBar.largeTitleTextAttributes = Constants.titleAttributes
        navigationBar.tintColor = .black
        navigationBar.barTintColor = CustColor.navigationBarColor

        let backImage = Images.backArrow
        navigationBar.backIndicatorImage = backImage
        navigationBar.backIndicatorTransitionMaskImage = backImage
        
        // Navigation bar clear color fix
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.largeTitleTextAttributes = Constants.titleAttributes
            appearance.backgroundColor = CustColor.navigationBarColor
            appearance.shadowColor = nil
            appearance.setBackIndicatorImage(backImage, transitionMaskImage: backImage)
            
            let backButtonAppearance = UIBarButtonItemAppearance()
            backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
            appearance.backButtonAppearance = backButtonAppearance

            navigationBar.standardAppearance = appearance
            navigationBar.scrollEdgeAppearance = appearance
        }
    }
}

