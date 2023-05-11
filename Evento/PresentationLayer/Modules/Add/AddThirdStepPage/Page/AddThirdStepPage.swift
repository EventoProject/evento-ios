//
//  AddThirdStepPage.swift
//  Evento
//
//  Created by Ramir Amrayev on 09.05.2023.
//

import SwiftUI

final class AddThirdStepViewModel: ObservableObject {
    // MARK: - Callbacks
    var didTapContinue: VoidCallback?
    
    @Published var addFlowModel: AddFlowModel
    
    init(addFlowModel: AddFlowModel) {
        self.addFlowModel = addFlowModel
    }
}

struct AddThirdStepPage: View {
    @ObservedObject var viewModel: AddThirdStepViewModel
    
    init(viewModel: AddThirdStepViewModel) {
        self.viewModel = viewModel
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        VStack {
            AddStepPageTitleView("Fill in the event description")
            AddStepIndicatorView(stepNumber: 3)
                .padding(.bottom, 30)
            DescriptionField(text: $viewModel.addFlowModel.description)
            WebsiteLinkField(link: $viewModel.addFlowModel.webSiteLink)
            
            Spacer()
            
            ButtonView(text: "Continue") {
                viewModel.didTapContinue?()
            }.padding(.bottom, 20)
        }.padding(.horizontal, 20)
    }
}

private struct DescriptionField: View {
    @Binding var text: String
    
    var body: some View {
        InputTextView(
            text: $text,
            title: "Enter a description of the event:",
            placeholder: "Minimum 150 words ...",
            limit: 1000
        ).padding(.bottom, 25)
    }
}

private struct WebsiteLinkField: View {
    @Binding var link: String
    
    var body: some View {
        InputTextField(
            text: $link,
            title: "Paste a link to the website:",
            placeholder: "https://",
            inputViewBackgroundColor: CustColor.backgroundColor
        )
    }
}

struct AddThirdStepPage_Previews: PreviewProvider {
    static var previews: some View {
        AddThirdStepPage(viewModel: AddThirdStepViewModel(addFlowModel: AddFlowModel()))
    }
}
