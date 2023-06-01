//
//  ProfileSetPage.swift
//  Evento
//
//  Created by RAmrayev on 28.05.2023.
//

import SwiftUI

struct ProfileSetPage: View {
    @ObservedObject var viewModel : ProfileSetViewModel
//    @Binding var model: InputViewModel
    var body: some View {
        VStack{
            InputTextField(
                model: $viewModel.fullName,
                title: "Full Name",
                placeholder: "Your Full Name",
                leftIcon: Images.personCircle
            ).padding(.top, 35)
            InputTextField(
                model: $viewModel.fullName,
                title: "Nick Name",
                placeholder: "Your nickname",
                leftIcon: Images.personCircle
            ).padding(.top, 35)
            InputTextField(
                model: $viewModel.fullName,
                title: "Password",
                placeholder: "Password",
                leftIcon: Images.key
            ).padding(.top, 35)
            ButtonView(text: "Save") {
                viewModel.setAccount()
            }
            Spacer()
        }.padding()
    }
}

struct ProfileSetPage_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSetPage(viewModel: ProfileSetViewModel())
    }
}
