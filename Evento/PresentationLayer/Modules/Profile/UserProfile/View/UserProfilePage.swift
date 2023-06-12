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
        VStack{
            ZStack{
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.white)
                    .shadow(color: Color.gray.opacity(0), radius: 4, x: 0, y: 2)
                    .padding()
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
                        )
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
                }.padding()
            }.background(CustColor.backgroundColor)
            VStack{
                List(viewModel.events, id: \.self) { event in
                    MyEventItemView(
                        event: event
                    )
                    .listRowSeparator(.hidden)
                    .listRowBackground(CustColor.backgroundColor)
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .background(CustColor.backgroundColor)
            }
            
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
