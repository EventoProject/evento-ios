//
//  ProfileSetViewModel.swift
//  Evento
//
//  Created by RAmrayev on 28.05.2023.
//

import Foundation
import SwiftUI
final class ProfileSetViewModel: ObservableObject {
    @State var fullName = InputViewModel()
    @State var email = ""
    @State var phoneNumber = ""
    func setAccount() {
        print("Profile was set")
    }
}
 
