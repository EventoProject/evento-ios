//
//  AddContainerPage.swift
//  Evento
//
//  Created by Ramir Amrayev on 06.05.2023.
//

import UIKit
import SnapKit

final class AddContainerPage: UIViewController {
    private let injection: CustInjection
    private var addCoordinator: AddCoordinator?
    private lazy var router = injection.inject(Router.self)
    
    private var addNavigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.navigationBar.tintColor = .black

        let backImage = Images.backArrow
        navigationController.navigationBar.backIndicatorImage = backImage
        navigationController.navigationBar.backIndicatorTransitionMaskImage = backImage
        navigationController.view.layer.cornerRadius = 30
        navigationController.view.layer.masksToBounds = true
        return navigationController
    }()
    
    init(injection: CustInjection) {
        self.injection = injection
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        makeConstraints()
    }
}

private extension AddContainerPage {
    func setup() {
        navigationItem.title = "Create your own event"
        view.backgroundColor = CustColor.navigationBarColor
        view.addSubview(addNavigationController.view)
        makeAddCoordinator()
    }
    
    func makeConstraints() {
        addNavigationController.view.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func makeAddCoordinator() {
        addCoordinator = AddCoordinator(
            injection: injection,
            router: router,
            navigationController: addNavigationController
        )
        addCoordinator?.start()
    }
}
