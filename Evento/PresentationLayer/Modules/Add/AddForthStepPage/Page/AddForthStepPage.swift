//
//  AddForthStepPage.swift
//  Evento
//
//  Created by Ramir Amrayev on 12.05.2023.
//

import SwiftUI

struct AddForthStepPage: View {
    @ObservedObject var viewModel: AddForthStepViewModel
    
    init(viewModel: AddForthStepViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            AddStepPageTitleView("Add other details")
            AddStepIndicatorView(stepNumber: 4)
                .padding(.bottom, 30)
            
            FormatsView(selecetdFormat: $viewModel.selectedFormat, formats: viewModel.formats) { format in
                viewModel.didSelectFormat(format: format)
            }
            PriceMainView(inputModel: $viewModel.priceModel, flowModel: $viewModel.addFlowModel)
            DateAndTimePicker(addFlowModel: $viewModel.addFlowModel)
            LocationView(inputModel: $viewModel.locationModel, flowModel: $viewModel.addFlowModel)
            Spacer()
            
            ButtonView(text: "Publish an event", isLoading: $viewModel.isLoadingButton) {
                viewModel.didTapPublishEvent?()
            }.padding(.bottom, 20)
        }.padding(.horizontal, 20)
    }
}

private struct FormatsView: View {
    @Binding var selecetdFormat: String?
    let formats: [String]
    let didSelectFormat: Callback<String>
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                CustText(text: "Format:", weight: .medium, size: 16)
                FormatButtonsView(
                    selecetedFormat: $selecetdFormat,
                    formats: formats,
                    didSelectFormat: didSelectFormat
                )
            }
            Spacer()
        }.padding(.bottom, 26)
    }
    
    private struct FormatButtonsView: View {
        @Binding var selecetedFormat: String?
        let formats: [String]
        let didSelectFormat: Callback<String>
        
        var body: some View {
            HStack(spacing: 13) {
                ForEach(formats, id: \.self) { format in
                    
                    let isSelected = Binding<Bool> (
                        get: {
                            selecetedFormat == format
                        },
                        set: { _ in
                            print("Error: trying to set binding property value")
                        }
                    )
                    
                    RoundedBorderButton(
                        isSelected: isSelected,
                        text: format
                    ) {
                        didSelectFormat(format)
                    }
                }
            }
        }
    }
}

private struct RoundedBorderButton: View {
    @Binding var isSelected: Bool
    let text: String
    let didTap: VoidCallback
    
    var body: some View {
        Button(
            action: didTap,
            label: {
                RoundedBorderText(isSelected: $isSelected, text: text)
            }
        )
    }
}

private struct PriceMainView: View {
    @Binding var inputModel: InputViewModel
    @Binding var flowModel: AddFlowModel
    
    var body: some View {
        VStack(alignment: .leading) {
            CustText(text: "Price:", weight: .medium, size: 16)
            HStack {
                InputView(
                    model: $inputModel,
                    placeholder: "Enter the cost",
                    backgroundColor: CustColor.backgroundColor
                )
                .onChange(of: inputModel) {
                    flowModel.priceText = $0.text
                }
                
                FreeView(inputModel: $inputModel)
            }
        }.padding(.bottom, 16)
    }
    
    private struct FreeView: View {
        @Binding var inputModel: InputViewModel
        
        var body: some View {
            HStack {
                Image(uiImage: Images.downArrowInCircle)
                
                CustText(text: "Free", weight: .regular, size: 16)
            }
            .background(Int(inputModel.text) ?? 0 > 0 ? Color.white : Color.yellow)
        }
    }
}

private struct DateAndTimePicker: View {
    @Binding var addFlowModel: AddFlowModel
    @State var selectedDate: Date = .now
    
    var body: some View {
        DatePicker(selection: $selectedDate,
                   label: {
            CustText(text: "Select date:", weight: .medium, size: 16)
        }
        )
        .environment(\.locale, Locale(identifier: "kz"))
        .padding(.bottom, 28)
        .onChange(of: selectedDate, perform: {
            addFlowModel.selectedDate = $0.toString(format: .ddMMyyyyHHmm)
        })
        .onAppear {
            addFlowModel.selectedDate = selectedDate.toString(format: .ddMMyyyyHHmm)
        }
    }
}

private struct LocationView: View {
    @Binding var inputModel: InputViewModel
    @Binding var flowModel: AddFlowModel
    
    var body: some View {
        InputTextField(
            model: $inputModel,
            title: "Location:",
            placeholder: "Enter the address",
            inputViewBackgroundColor: CustColor.backgroundColor
        )
        .onChange(of: inputModel) {
            flowModel.location = $0.text
        }
    }
}

struct AddForthStepPage_Previews: PreviewProvider {
    static var previews: some View {
        AddForthStepPage(viewModel: AddForthStepViewModel(addFlowModel: AddFlowModel()))
    }
}
