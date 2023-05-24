//
//  AddFirstStepPage.swift
//  Evento
//
//  Created by Ramir Amrayev on 06.05.2023.
//

import SwiftUI

struct AddFirstStepPage: View {
    @ObservedObject var viewModel: AddFirstStepViewModel
    
    var body: some View {
        VStack {
            AddStepPageTitleView("Event name and poster")
            AddStepIndicatorView(stepNumber: 1)
                .padding(.bottom, 36)
            NameInputView(inputModel: $viewModel.eventNameModel, flowModel: $viewModel.addFlowModel)
            UploadPosterView(imageModel: $viewModel.imageModel, flowModel: $viewModel.addFlowModel) {
                viewModel.didTapUploadPoster()
            }
            
            Spacer()
            
            ButtonView(text: "Continue") {
                viewModel.didTapContinue()
            }.padding(.bottom, 40)
        }.padding(.horizontal, 20)
    }
}

private struct NameInputView: View {
    @Binding var inputModel: InputViewModel
    @Binding var flowModel: AddFlowModel
    
    var body: some View {
        InputTextField(
            model: $inputModel,
            title: "Come up with the name of the event:",
            placeholder: "Enter event name",
            inputViewBackgroundColor: CustColor.backgroundColor
        ).padding(.bottom, 32)
            .onChange(of: inputModel) {
                flowModel.eventName = $0.text
            }
    }
}

private struct UploadPosterView: View {
    @Binding var imageModel: ImageModel
    @Binding var flowModel: AddFlowModel
    var didTap: VoidCallback
    
    var body: some View {
        VStack(alignment: .leading) {
            SubtitleView()
            PosterImageView(
                imageModel: $imageModel,
                flowModel: $flowModel,
                didTap: didTap
            )
            
            if case let .error(text) = imageModel.state {
                ErrorTextView(text: text)
            }
        }
    }
    
    struct SubtitleView: View {
        var body: some View {
            HStack {
                CustText(
                    text: "Upload the poster:",
                    weight: .medium,
                    size: 16
                )
                Spacer()
            }
        }
    }
    
    struct PosterImageView: View {
        @Binding var imageModel: ImageModel
        @Binding var flowModel: AddFlowModel
        var didTap: VoidCallback
        
        var body: some View {
            Button(
                action: didTap,
                label: {
                    Group {
                        if let posterImage = imageModel.image {
                            SelectedImageView(image: posterImage)
                        } else {
                            PlaceholderImageView(state: $imageModel.state)
                        }
                    }
                    .onChange(of: imageModel.image) { image in
                        if image != nil {
                            imageModel.state = .default
                        }
                        flowModel.image = image
                    }
                }
            )
        }
        
        struct PlaceholderImageView: View {
            @Binding var state: InputViewState
            
            var body: some View {
                HStack {
                    Spacer()
                    Image(uiImage: Images.uploadImagePlaceholder)
                    Spacer()
                }
                .padding(.vertical, 60)
                .background(CustColor.backgroundColor)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .strokeBorder(state == .default ? .clear : CustColor.errorColor , lineWidth: 1)
                )
            }
        }
        
        struct SelectedImageView: View {
            let image: UIImage
            var body: some View {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(20)
                    .frame(width: 360, height: 200)
            }
        }
    }
}

struct AddFirstStepPage_Previews: PreviewProvider {
    static var previews: some View {
        AddFirstStepPage(viewModel: AddFirstStepViewModel())
    }
}
