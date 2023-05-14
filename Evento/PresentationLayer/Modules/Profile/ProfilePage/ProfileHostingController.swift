//
//  ProfileHostingController.swift
//  Evento
//
//  Created by  Yeskendir Ayat on 14.05.2023.
//

import SwiftUI

final class ProfileHostingController: UIHostingController<ProfilePage> {
    
    let settingButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup(){
        navigationController?.navigationBar.prefersLargeTitles = false
        let custCgColor = CustColor.purple.cgColor ?? UIColor.purple.cgColor
        navigationController?.navigationBar.tintColor = UIColor(cgColor: custCgColor)

        // Set up the  button
        settingButton.setImage(Images.settingImage, for: .normal)
        settingButton.addTarget(self, action: #selector(settingButtonTapped), for: .touchUpInside)
        
        // Set the  button as the right navigation bar button item of the navigation controller
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: settingButton)
    }
    
    @objc private func settingButtonTapped() {
        // Handle bell button tapped
    }
}

