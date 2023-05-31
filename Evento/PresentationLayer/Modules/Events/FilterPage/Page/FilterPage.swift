//
//  FilterPage.swift
//  Evento
//
//  Created by Ramir Amrayev on 27.05.2023.
//

import SwiftUI

struct FilterPage: View {
    @ObservedObject var viewModel: FilterViewModel
    
    var body: some View {
        VStack(spacing: 25) {
            categoryMenu
            formatAgeLimitMenus
            priceRangeView
            dateRangeView
            Spacer()
            ButtonView(text: "Apply filters") {
                viewModel.didTapApplyFilters()
            }
        }
        .padding(25)
    }
    
    private var categoryMenu: some View {
        CustMenuView(
            selectedItem: $viewModel.selectedCategoryMenuItem,
            title: "Category",
            hiddenPickerTitle: "Select category",
            items: viewModel.menuCategories
        )
    }
    
    private var formatAgeLimitMenus: some View {
        HStack(spacing: 25) {
            CustMenuView(
                selectedItem: $viewModel.selectedFormatMenuItem,
                title: "Format",
                hiddenPickerTitle: "Select format",
                items: viewModel.menuFormats
            )
            CustMenuView(
                selectedItem: $viewModel.selectedAgeLimitMenuItem,
                title: "Age limit",
                hiddenPickerTitle: "Select age limit",
                items: viewModel.menuAgeLimits
            )
        }
    }
    
    private var priceRangeView: some View {
        VStack(alignment: .leading) {
            CustText(text: "Price:", weight: .medium, size: 16)
            HStack(spacing: 25) {
                InputView(
                    model: $viewModel.fromPriceInputModel,
                    placeholder: "From",
                    backgroundColor: CustColor.backgroundColor
                )
                InputView(
                    model: $viewModel.toPriceInputModel,
                    placeholder: "To",
                    backgroundColor: CustColor.backgroundColor
                )
            }
        }
    }
    
    private var dateRangeView: some View {
        VStack {
            datePickerView(title: "From date", date: $viewModel.fromDate)
            datePickerView(title: "To date", date: $viewModel.toDate)
        }
    }
    
    @ViewBuilder
    private func datePickerView(title: String, date: Binding<Date>) -> some View {
        DatePicker(
            selection: date,
            displayedComponents: .date,
            label: {
                CustText(text: "\(title):", weight: .medium, size: 16)
            }
        )
        .environment(\.locale, Locale(identifier: "kz"))
    }
}

struct FilterPage_Previews: PreviewProvider {
    static var previews: some View {
        FilterPage(viewModel: FilterViewModel(
            apiManager: AddApiManager(
                webService: WebService(
                    keychainManager: KeychainManager()
                )
            )
        ))
    }
}
