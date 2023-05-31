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
            
            formatAgeLimitView
            PriceMainView(inputModel: $viewModel.priceModel, flowModel: $viewModel.addFlowModel)
            DateAndTimePicker(addFlowModel: $viewModel.addFlowModel)
            AddressView(inputModel: $viewModel.addressModel, flowModel: $viewModel.addFlowModel)
            Spacer()
            
            ButtonView(text: "Publish an event", isLoading: $viewModel.isLoadingButton) {
                viewModel.didTapPublishEvent()
            }.padding(.bottom, 20)
        }.padding(.horizontal, 20)
    }
    
    private var formatAgeLimitView: some View {
        HStack(spacing: 25) {
            CustMenuView(
                selectedItem: $viewModel.addFlowModel.format,
                type: .format
            )
            CustMenuView(
                selectedItem: $viewModel.addFlowModel.ageLimit,
                type: .ageLimit
            )
        }
        .padding(.bottom, 15)
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
        @State private var isSelected: Bool
        
        init(inputModel: Binding<InputViewModel>) {
            self._inputModel = inputModel
            isSelected = Int(inputModel.wrappedValue.text) ?? 0 == 0
        }
        
        var body: some View {
            RoundedBorderButton(
                isSelected: $isSelected,
                text: "Free",
                didTap: {}
            )
            .onChange(of: inputModel) {
                isSelected = Int($0.text) ?? 0 == 0
            }
        }
    }
}

private struct DateAndTimePicker: View {
    @Binding var addFlowModel: AddFlowModel
    @State var selectedDate: Date = .now
    
    var body: some View {
        DatePicker(selection: $selectedDate,
                   label: {
            CustText(text: "Date and time:", weight: .medium, size: 16)
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

private struct AddressView: View {
    @Binding var inputModel: InputViewModel
    @Binding var flowModel: AddFlowModel
    
    var body: some View {
        InputTextField(
            model: $inputModel,
            title: "Address:",
            placeholder: "Enter the full address",
            inputViewBackgroundColor: CustColor.backgroundColor
        )
        .onChange(of: inputModel) {
            flowModel.fullAddress = $0.text
        }
    }
}

struct AddForthStepPage_Previews: PreviewProvider {
    static var previews: some View {
        AddForthStepPage(viewModel: AddForthStepViewModel(
            addFlowModel: AddFlowModel(),
            apiManager: AddApiManager(
                webService: WebService(
                    keychainManager: KeychainManager()
                )
            )
        ))
    }
}
