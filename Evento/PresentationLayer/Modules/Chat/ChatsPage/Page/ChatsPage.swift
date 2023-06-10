//
//  ChatsPage.swift
//  Evento
//
//  Created by Ramir Amrayev on 10.06.2023.
//

import SwiftUI

struct ChatsPage: View {
    @ObservedObject var viewModel: ChatsViewModel
    
    var body: some View {
        List(viewModel.chats, id: \.self) { chat in
            ChatItemView(chat: chat) {
                viewModel.didTap(chat: chat)
            }
            .listRowSeparator(.hidden)
            .listRowBackground(CustColor.backgroundColor)
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .background(CustColor.backgroundColor)
        .refreshable {
            viewModel.refresh()
        }
    }
}

private struct ChatItemView: View {
    let chat: ChatsResponseItemModel
    let didTap: VoidCallback
    
    var body: some View {
        Button(
            action: didTap,
            label: {
                HStack(alignment: .top, spacing: 11) {
                    AsyncAvatarImage(
                        url: chat.userImageLink,
                        size: 60
                    )
                    VStack(alignment: .leading, spacing: 4) {
                        userNameTimeView
                        CustText(text: chat.lastMessageContent, weight: .regular, size: 16)
                    }
                }
                .padding(14)
                .background(.white)
                .cornerRadius(20)
            }
        )
    }
    
    private var userNameTimeView: some View {
        HStack {
            CustText(text: chat.userName, weight: .medium, size: 16)
                .foregroundGradient()
            Spacer()
            CustText(text: "6 min ago", weight: .regular, size: 14)
                .foregroundColor(CustColor.lightGray)
        }
    }
}

struct ChatsPage_Previews: PreviewProvider {
    static var previews: some View {
        ChatsPage(viewModel: ChatsViewModel(
            apiManager: ChatApiManager(
                webService: WebService(
                    keychainManager: KeychainManager()
                )
            )
        ))
    }
}
