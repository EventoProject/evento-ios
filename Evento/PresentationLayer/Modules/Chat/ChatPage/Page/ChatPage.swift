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
        VStack {
            ScrollViewReader { scrollView in
                List(viewModel.messages, id: \.self) { message in
                    let isMy = viewModel.userId == message.senderId
                    MessageView(
                        isMy: isMy,
                        userImageUrl: isMy ? viewModel.userImageUrl : viewModel.otherUserImageUrl,
                        message: message
                    )
                    .listRowSeparator(.hidden)
                    .listRowBackground(CustColor.backgroundColor)
                    .id(message)
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .background(CustColor.backgroundColor)
                .onChange(of: viewModel.messages) { _ in
                    scrollView.scrollTo(viewModel.messages.last, anchor: .bottom)
                }
            }
            
            SendInputView(
                inputModel: $viewModel.messageInputModel,
                placeholder: "Type message...",
                backgroundColor: .white
            ) {
                viewModel.didTapSendMessage()
            }
            .padding([.horizontal, .bottom], 20)
            .background(CustColor.backgroundColor)
        }
        .background(CustColor.backgroundColor)
        .onAppear { viewModel.onAppear() }
        .onDisappear { viewModel.onDisappear() }
    }
}

private struct MessageView: View {
    let isMy: Bool
    let userImageUrl: String?
    let message: MessageModel
    
    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            if isMy {
                Spacer()
                HStack(spacing: 14) {
                    timeView
                    messageView
                }
                avatarImageView
            } else {
                avatarImageView
                HStack(spacing: 14) {
                    messageView
                    timeView
                }
            }
        }
    }
    
    private var avatarImageView: some View {
        AsyncAvatarImage(url: userImageUrl ?? "", size: 50)
    }
    
    private var messageView: some View {
        CustText(text: message.content, weight: .regular, size: 16)
            .padding(.vertical, 18)
            .padding(.horizontal, 14)
            .background(.white)
            .cornerRadius(20)
    }
    
    private var timeView: some View {
        CustText(
            text: message.sentAt.toDate(with: .yyyyMMddTHHmmssSSSZ)?.toString(format: .hhmm) ?? "",
            weight: .regular,
            size: 14
        )
        .foregroundColor(CustColor.lightGray)
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
            keychainManager: KeychainManager(),
            websocketManager: WebSocketManager()
        ))
    }
}
