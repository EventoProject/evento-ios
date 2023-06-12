//
//  ProfileHostingController.swift
//  Evento
//
//  Created by RAmrayev on 28.05.2023.
//

import Foundation
import SwiftUI
import Combine

final class ProfileHostingController: UIHostingController<ProfilePage> {
    var didBell: VoidCallback?
    var didSaveTapped: VoidCallback?
    lazy var settingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(Images.settingImage, for: .normal)
        button.addTarget(self, action: #selector(settingButtonTapped), for: .touchUpInside)
        return button
    }()
    lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(Images.save, for: .normal)
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup(){
        navigationController?.navigationBar.prefersLargeTitles = false
        let custCgColor = CustColor.purple.cgColor ?? UIColor.purple.cgColor
        navigationController?.navigationBar.tintColor = UIColor(cgColor: custCgColor)
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: saveButton), UIBarButtonItem(customView: settingButton)]
    }
    @objc private func settingButtonTapped() {
        self.didBell?()
    }
    @objc private func saveButtonTapped() {
        self.didSaveTapped?()
    }
}
