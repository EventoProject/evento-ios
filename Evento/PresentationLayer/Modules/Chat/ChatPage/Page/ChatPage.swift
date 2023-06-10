//
//  ChatPage.swift
//  Evento
//
//  Created by Ramir Amrayev on 10.06.2023.
//

import SwiftUI

struct ChatPage: View {
    @ObservedObject var viewModel: ChatViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ChatPage_Previews: PreviewProvider {
    static var previews: some View {
        ChatPage(viewModel: ChatViewModel(
            chatId: "1_2",
            apiManager: ChatApiManager(
                webService: WebService(
                    keychainManager: KeychainManager()
                )
            ),
            keychainManager: KeychainManager()
        ))
    }
}
