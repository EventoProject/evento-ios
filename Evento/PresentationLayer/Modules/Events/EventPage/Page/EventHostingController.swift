//
//  EventHostingController.swift
//  Evento
//
//  Created by Ramir Amrayev on 24.05.2023.
//

import SwiftUI

private enum Constants {
    static let largeTitleFont = MontserratFont.createUIFont(weight: .semiBold, size: 23)
    static let titleFont = MontserratFont.createUIFont(weight: .semiBold, size: 20)
    static let largeTitleAttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: UIColor.black,
        .font: largeTitleFont
    ]
    static let titleAttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: UIColor.black,
        .font: titleFont
    ]
}

final class EventHostingController: UIHostingController<EventPage> {
    private let navBarTitleView: UILabel = {
        let label = UILabel()
        label.font = MontserratFont.createUIFont(weight: .semiBold, size: 20)
        label.text = "Event"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = Constants.largeTitleAttributes
        navigationController?.navigationBar.titleTextAttributes = Constants.titleAttributes
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.barTintColor = CustColor.navigationBarColor

        let backImage = Images.backArrow
        navigationController?.navigationBar.backIndicatorImage = backImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        
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
            
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
    }
}
