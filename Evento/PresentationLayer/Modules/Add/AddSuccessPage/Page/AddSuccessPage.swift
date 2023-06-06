//
//  AddSuccessPage.swift
//  Evento
//
//  Created by Ramir Amrayev on 20.05.2023.
//

import SwiftUI

struct AddSuccessPage: View {
    @ObservedObject var viewModel: AddSuccessViewModel
    
    var body: some View {
        VStack(spacing: 7) {
            Spacer()
            Image(uiImage: Images.logoSmileGradient)
                .padding(.bottom, 28)
            CustText(text: "Thank you!", weight: .semiBold, size: 23)
            CustText(text: viewModel.title, weight: .medium, size: 16)
                .padding(.bottom, 15)
            CustText(text: viewModel.subtitle, weight: .regular, size: 16)
                .multilineTextAlignment(.center)
            ButtonView(text: viewModel.buttonTitle) {
                viewModel.didTapButton()
            }
            .padding(.top, 41)
            .padding(.horizontal, 27)
            Spacer()
        }
        .onDisappear {
            viewModel.onDisappear?()
        }
    }
}

struct AddSuccessPage_Previews: PreviewProvider {
    static var previews: some View {
        AddSuccessPage(viewModel: AddSuccessViewModel(
            title: "Event created successfully",
            subtitle: "Your Event has been accepted and will be published in the feed",
            buttonTitle: "Back to events"
        ))
    }
}
