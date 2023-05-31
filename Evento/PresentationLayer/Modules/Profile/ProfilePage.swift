//
//  ProfilePage.swift
//  Evento
//
//  Created by RAmrayev on 28.05.2023.
//

import SwiftUI
import Foundation

struct ProfilePage: View {
    @ObservedObject var viewModel: ProfileViewModel
    @State var imagePicker : ProfileImageView
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        self.imagePicker = ProfileImageView(viewModel: viewModel)
    }
    var body: some View {
        imagePicker
        Text(viewModel.user!.name)
    }
}
struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage(viewModel: ProfileViewModel(
            apiManager: ProfileApiManager(
                webService: WebService(
                    keychainManager: KeychainManager()
                )
            )
        ))
    }
}
