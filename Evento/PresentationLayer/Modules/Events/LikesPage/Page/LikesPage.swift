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
            LikeView(
                like: like,
                isUserLike: viewModel.userId == like.id
            ) { follow in
                viewModel.didTapFollow(like: like, follow: follow)
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
    }
}

private struct LikeView: View {
    let like: LikeItemModel
    let isUserLike: Bool
    let didTapFollow: Callback<Bool>
    @State private var isFollowing: Bool
    
    init(like: LikeItemModel, isUserLike: Bool, didTapFollow: @escaping Callback<Bool>) {
        self.like = like
        self.isUserLike = isUserLike
        self.didTapFollow = didTapFollow
        isFollowing = like.isFollowing
    }
    
    var body: some View {
        HStack(spacing: 13) {
            AsyncAvatarImage(url: like.imageLink.string, size: 60)
            userNameView
            Spacer()
            if !isUserLike {
                followButton
            }
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
        ButtonView(
            text: isFollowing ? "Following" : "Follow",
            type: .small,
            isFilled: !isFollowing
        ) {
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
                ),
                keychainManager: KeychainManager()
            )
        )
    }
}
