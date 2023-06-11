//
//  CommentsPage.swift
//  Evento
//
//  Created by Ramir Amrayev on 31.05.2023.
//

import SwiftUI

struct CommentsPage: View {
    @ObservedObject var viewModel: CommentsViewModel
    
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.comments, id: \.commentId) { comment in
                    CommentView(comment) {
                        viewModel.didTapReply(comment)
                    }
                    .listRowSeparator(.hidden)
                    .deleteDisabled(viewModel.userId != comment.userId)
                }
                .onDelete(perform: viewModel.didTapDelete)
            }
            .listStyle(.plain)
            
            SendInputView(
                inputModel: $viewModel.commentModel,
                placeholder: "Add a comment...",
                backgroundColor: CustColor.backgroundColor,
                avatarImageUrl: viewModel.avatarImageUrl
            ) {
                viewModel.didTapSendComment()
            }
            .padding([.horizontal, .bottom], 20)
        }
    }
}

private struct CommentView: View {
    let comment: CommentItemModel
    let didTapReply: VoidCallback
    
    init(_ comment: CommentItemModel, didTapReply: @escaping VoidCallback) {
        self.comment = comment
        self.didTapReply = didTapReply
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            avatarNameView
            CustText(text: comment.content, weight: .regular, size: 16)
            replyButton
        }
    }
    
    private var avatarNameView: some View {
        HStack {
            AsyncAvatarImage(url: comment.imageLink.string, size: 40)
            fullnameUsernameView
        }.padding(.bottom, 11)
    }
    
    private var fullnameUsernameView: some View {
        VStack(alignment: .leading) {
            HStack{
                CustText(text: comment.name, weight: .regular, size: 16)
                CustText(text: "2 hr ago", weight: .regular, size: 14)
                    .foregroundColor(CustColor.lightGray)
            }
            CustText(text: "@\(comment.username)", weight: .regular, size: 16)
                .foregroundColor(CustColor.lightGray)
        }
    }
    
    private var replyButton: some View {
        Button(
            action: didTapReply,
            label: {
                CustText(text: "Reply", weight: .regular, size: 14)
                    .foregroundColor(CustColor.lightGray)
            }
        ).padding(.top, 7)
    }
}

struct CommentsPage_Previews: PreviewProvider {
    static var previews: some View {
        CommentsPage(
            viewModel: CommentsViewModel(
                eventId: 1,
                apiManager: EventsApiManager(
                    webService: WebService(
                        keychainManager: KeychainManager()
                    )
                ),
                keychainManager: KeychainManager()
            )
        )
    }
}
