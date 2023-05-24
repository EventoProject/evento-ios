//
//  AddSecondStepPage.swift
//  Evento
//
//  Created by Ramir Amrayev on 07.05.2023.
//

import SwiftUI

struct AddSecondStepPage: View {
    @ObservedObject var viewModel: AddSecondStepViewModel
    
    var body: some View {
        VStack {
            AddStepPageTitleView("Choose category")
            AddStepIndicatorView(stepNumber: 2)
                .padding(.bottom, 10)
            
            CategoriesView(categories: $viewModel.categories) { category in
                viewModel.didSelectCategory(category: category)
            }
            
            Spacer()
        }.padding(.horizontal, 20)
    }
}

private struct CategoriesView: View {
    @Binding var categories: [CategoryModel]
    let didSelectCategory: Callback<CategoryModel>
    
    var body: some View {
        List(categories, id: \.self) { category in
            CategoryView(category: category) {
                didSelectCategory(category)
            }
        }
        .listStyle(PlainListStyle())
        .padding(.horizontal, -10)
    }
}

private struct CategoryView: View {
    let category: CategoryModel
    let didTap: VoidCallback
    
    var body: some View {
        Button(
            action: didTap,
            label: {
                HStack {
                    CustText(text: category.name, weight: .regular, size: 16)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 9)
            }
        )
    }
}

struct AddSecondStepPage_Previews: PreviewProvider {
    static var previews: some View {
        AddSecondStepPage(viewModel: AddSecondStepViewModel(
            addFlowModel: AddFlowModel(),
            apiManager: AddApiManager(
                webService: WebService(
                    keychainManager: KeychainManager()
                )
            )
        ))
    }
}
