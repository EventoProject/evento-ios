//
//  GeneralPage.swift
//  Evento
//
//  Created by RAmrayev on 28.05.2023.
//

import SwiftUI
struct GeneralPage: View {
    @ObservedObject var viewModel: GeneralViemModel
    
    var body: some View {
        VStack {
            ListView(categories: viewModel.categories){_ in}
            Spacer()
            ButtonView(text: "logout") {
                viewModel.didTapLogOut?()
            }
        }.padding(.horizontal, 20)
    }
}

private struct ListView: View {
    let categories: [String]
    let didSelectCategory: Callback<String>
    
    var body: some View {
        List(categories, id: \.self) { category in
            ButtonsView(category: category) {
                didSelectCategory(category)
            }
        }
        .listStyle(PlainListStyle())
        .padding(.horizontal, -10)
    }
}

private struct ButtonsView: View {
    let category: String
    let didTap: VoidCallback
    
    var body: some View {
        Button(
            action: didTap,
            label: {
                HStack {
                    CustText(text: category, weight: .regular, size: 16)
                    Spacer()
                }
                .padding(.vertical, 9)
            }
        )
    }
}
struct GeneralPage_Previews: PreviewProvider {
    static var previews: some View {
        GeneralPage(viewModel: GeneralViemModel())
    }
}
