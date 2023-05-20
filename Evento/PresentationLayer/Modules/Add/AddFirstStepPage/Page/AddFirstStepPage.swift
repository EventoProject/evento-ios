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
            UploadPosterView(posterImage: $viewModel.addFlowModel.posterImage) {
                viewModel.didTapUploadPoster()
            }
            
            Spacer()
            
            ButtonView(text: "Continue") {
                viewModel.didTapContinue?()
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
    @Binding var posterImage: UIImage?
    var didTap: VoidCallback
    
    var body: some View {
        VStack {
            SubtitleView()
            PosterImageView(posterImage: $posterImage, didTap: didTap)
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
        @Binding var posterImage: UIImage?
        var didTap: VoidCallback
        
        var body: some View {
            Button(
                action: didTap,
                label: {
                    if let posterImage {
                        SelectedImageView(image: posterImage)
                    } else {
                        PlaceholderImageView()
                    }
                }
            )
        }
        
        struct PlaceholderImageView: View {
            var body: some View {
                HStack {
                    Spacer()
                    Image(uiImage: Images.uploadImagePlaceholder)
                    Spacer()
                }
                .padding(.vertical, 60)
                .background(CustColor.backgroundColor)
                .cornerRadius(20)
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
