//
//  UserProfilePage.swift
//  Evento
//
//  Created by RAmrayev on 11.06.2023.
//

import SwiftUI

struct UserProfilePage: View {
    
    @ObservedObject var viewModel: UserProfileViewModel

    init(viewModel: UserProfileViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                    VStack(spacing: 8) {
                        profileInfo
                            .background(Color.white)
                            .cornerRadius(20)
                            .padding(.horizontal, 10)
                        ScrollViewReader { scrollViewProxy in
                            VStack {
                                ForEach(0..<viewModel.shares.count, id: \.self) { share in
                                    ShareItemView(
                                        shareModel: viewModel.shares[share],
                                        didTapUser: {
                        //                    viewModel.didTapShareUser(shareModel: share)
                                        },
                                        didTapEvent: {
                                            viewModel.didTapShareEvent(shareModel: viewModel.shares[share])
                                        }
                                    )
                                    .foregroundColor(.black)
                                    .frame(width: geometry.size.width-20, height: 410)
                                    .background(Color.white)
                                    .cornerRadius(20)
                                    .padding(.horizontal, 10)
                                }
                            }
                            .onChange(of: geometry.size, perform: { value in
                                scrollViewProxy.scrollTo(0, anchor: .top)
                            })
                        }
                    }
            }.background(CustColor.backgroundColor)
        }
            
    }
    private var profileInfo: some View {
        VStack{
            if ((viewModel.user?.imageLink.isEmpty) != nil){
                AsyncImage(
                    url: URL(string: (viewModel.user?.imageLink)!),
                    content: { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(CustLinearGradient, lineWidth: 3))
                    },
                    placeholder: {
                        Image("person_circle")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(CustLinearGradient, lineWidth: 3))
                    }
                ).padding(.top, 10)
            }
            if (viewModel.user.self != nil){
                CustText(text: viewModel.user!.name , weight: .regular, size: 20)
                CustText(text: "@\(viewModel.user!.email)" , weight: .regular, size: 14).padding(.bottom, 5).foregroundColor(.gray)
                HStack(spacing: 10){
                    CustText(text: "\(viewModel.user!.subscriptions) \n following", weight: .thin, size: 14)      .multilineTextAlignment(.center)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundColor(.black)
                    CustText(text: "\(viewModel.user!.subscribers)\n followers", weight: .thin, size: 14)
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundColor(.black)
                    CustText(text: "\(viewModel.user!.events)\n events", weight: .thin, size: 14)
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundColor(.black)
                }
                .background(.white)
                .cornerRadius(10)
            }
            HStack(spacing: 5){
                ButtonView(
                    text: viewModel.user?.following ?? false ? "Following" : "Follow",
                    type: .small,
                    isFilled: !(viewModel.user?.following ?? false)
                ) {
                    viewModel.didTapFollow()
                }
                ButtonView(
                    text: "Message",
                    isLoading: $viewModel.isLoadingButton,
                    type: .small,
                    isFilled: false
                ) {
                    viewModel.checkChatRoomExists()
                }.progressViewStyle(CircularProgressViewStyle(tint: .black))
            }.padding()
        }
    }
}


struct UserProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        UserProfilePage(viewModel: UserProfileViewModel(
            apiManager: ProfileApiManager(
                webService: WebService(
                    keychainManager: KeychainManager())), eventApiManager: EventsApiManager(webService: WebService(keychainManager: KeychainManager())), chatApiManager: ChatApiManager(webService: WebService(keychainManager: KeychainManager())), id: 1))
    }
}
