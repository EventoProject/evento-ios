//
//  LikesPage.swift
//  Evento
//
//  Created by Ramir Amrayev on 30.05.2023.
//

import SwiftUI

struct LikesPage: View {
    @ObservedObject var viewModel: LikesViewModel
    
    var body: some View {
        List(viewModel.likes, id: \.self) { like in
            LikeView(like) { follow in
                viewModel.didTapFollow(like: like, follow: follow)
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
    }
}

private struct LikeView: View {
    let like: LikeItemModel
    let didTapFollow: Callback<Bool>
    @State private var isFollowing: Bool
    
    init(_ like: LikeItemModel, didTapFollow: @escaping Callback<Bool>) {
        self.like = like
        self.didTapFollow = didTapFollow
        isFollowing = like.id == 3
    }
    
    var body: some View {
        HStack(spacing: 13) {
            AsyncAvatarImage(url: like.imageLink.string, size: 60)
            userNameView
            Spacer()
            followButton
        }
    }
    
    private var userNameView: some View {
        VStack(alignment: .leading) {
            CustText(text: like.name, weight: .regular, size: 16)
            CustText(text: "@\(like.username)", weight: .regular, size: 15.5)
                .foregroundColor(CustColor.lightGray)
        }
    }
    
    private var followButton: some View {
        ButtonView(text: "Follow", type: .small, isFilled: !isFollowing) {
            isFollowing.toggle()
            didTapFollow(isFollowing)
        }.frame(width: 115)
    }
}

struct LikesPage_Previews: PreviewProvider {
    static var previews: some View {
        LikesPage(
            viewModel: LikesViewModel(
                eventId: 3,
                apiManager: EventsApiManager(
                    webService: WebService(
                        keychainManager: KeychainManager()
                    )
                )
            )
        )
    }
}
