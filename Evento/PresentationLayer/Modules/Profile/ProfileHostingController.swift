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
    let settingButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup(){
        navigationController?.navigationBar.prefersLargeTitles = false
        let custCgColor = CustColor.purple.cgColor ?? UIColor.purple.cgColor
        navigationController?.navigationBar.tintColor = UIColor(cgColor: custCgColor)
        settingButton.setImage(Images.settingImage, for: .normal)
        settingButton.addTarget(self, action: #selector(settingButtonTapped), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: settingButton)
    }
    @objc private func settingButtonTapped() {
        self.didBell?()
    }
}
