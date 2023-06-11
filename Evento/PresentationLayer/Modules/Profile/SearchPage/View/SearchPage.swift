//
//  SearchPage.swift
//  Evento
//
//  Created by RAmrayev on 10.06.2023.
//

import SwiftUI

struct SearchPage: View {
    @ObservedObject var viewModel: SearchViewModel
    @State var searchText: String = ""
//    init(searchText: Binding<String>) {
//        _searchText = searchText
//    }
    var filteredUsers: [SearchUserModel] {
        if searchText.isEmpty {
            return viewModel.users
        } else {
            return viewModel.users.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        ZStack{
            HStack() {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("Search", text: $searchText)
            }
            .padding(8)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)
            .padding(.horizontal, 20)
        }
        .padding(2)
        .background(CustColor.backgroundColor)

        List(filteredUsers, id: \.self) { user in
            SearchUserView(user: user).onTapGesture {
                viewModel.showUserProfile!(user.id)
            }
        }
        .listStyle(.plain)
    }
}

private struct SearchUserView: View {
    let user: SearchUserModel
    init(user: SearchUserModel) {
        self.user = user
    }
    var body: some View {
        HStack(spacing: 13) {
            AsyncAvatarImage(url: user.imageLink, size: 60)
            userNameView
        }
    }
    
    private var userNameView: some View {
        VStack(alignment: .leading) {
            CustText(text: user.name, weight: .regular, size: 16)
            CustText(text: "@\(user.username)", weight: .regular, size: 15.5)
                .foregroundColor(CustColor.lightGray)
        }
    }
}
struct SearchPage_Previews: PreviewProvider {
    static var previews: some View {
        SearchPage(viewModel: SearchViewModel(apiManager: ProfileApiManager(webService: WebService(keychainManager: KeychainManager()))))
    }
}
