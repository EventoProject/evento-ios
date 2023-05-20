//
//  AddThirdStepPage.swift
//  Evento
//
//  Created by Ramir Amrayev on 09.05.2023.
//

import SwiftUI

struct AddThirdStepPage: View {
    @ObservedObject var viewModel: AddThirdStepViewModel
    
    init(viewModel: AddThirdStepViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            AddStepPageTitleView("Fill in the event description")
            AddStepIndicatorView(stepNumber: 3)
                .padding(.bottom, 30)
            DescriptionField(text: $viewModel.addFlowModel.description)
            WebsiteLinkField(inputModel: $viewModel.webSiteModel, flowModel: $viewModel.addFlowModel)
            
            Spacer()
            
            ButtonView(text: "Continue", isLoading: $viewModel.isLoadingContinue) {
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
    @Binding var inputModel: InputViewModel
    @Binding var flowModel: AddFlowModel
    
    var body: some View {
        InputTextField(
            model: $inputModel,
            title: "Paste a link to the website:",
            placeholder: "https://",
            inputViewBackgroundColor: CustColor.backgroundColor
        )
        .onChange(of: inputModel) {
            flowModel.webSiteLink = $0.text
        }
    }
}

struct AddThirdStepPage_Previews: PreviewProvider {
    static var previews: some View {
        AddThirdStepPage(viewModel: AddThirdStepViewModel(addFlowModel: AddFlowModel()))
    }
}
