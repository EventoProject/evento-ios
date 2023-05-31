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
        List(viewModel.comments, id: \.self) { comment in
            CommentView(comment) {
                viewModel.didTapReply(comment)
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
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
        VStack {
            
        }
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
                )
            )
        )
    }
}
