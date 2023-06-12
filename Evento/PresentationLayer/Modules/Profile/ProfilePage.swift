//
//  ProfilePage.swift
//  Evento
//
//  Created by RAmrayev on 28.05.2023.
//

import SwiftUI
import Foundation

struct ProfilePage: View {
    @ObservedObject var profileViewModel: ProfileViewModel
    @State var imagePicker : ProfileImageView
    var searchTap: VoidCallback?
    let iist:[Int] = [1,2,3,4]
    init(profileViewModel: ProfileViewModel) {
        self.profileViewModel = profileViewModel
        imagePicker = ProfileImageView(viewModel: profileViewModel)
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
                                ForEach(0..<profileViewModel.shares.count, id: \.self) { share in
                                    ShareItemView(
                                        shareModel: profileViewModel.shares[share],
                                        didTapUser: {
                                        },
                                        didTapEvent: {
                                            profileViewModel.didTapShareEvent(shareModel: profileViewModel.shares[share])
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
                    }.refreshable {
                        profileViewModel.refresh()
                    }
            }
            .refreshable {
                profileViewModel.refresh()
            }
            .background(CustColor.backgroundColor)
        }.refreshable {
            profileViewModel.refresh()
        }
    }
    
    private var profileInfo: some View {
        VStack{
            if (profileViewModel.user.self != nil){
                imagePicker
                ProfileCardView(profileViewModel: profileViewModel)
            }
            SearchView()
                .padding(10)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(15)
                .padding()
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                .onTapGesture {
                    profileViewModel.showSearchPage()
                }
        }
    }
}
struct ProfileCardView: View{
    var profileViewModel: ProfileViewModel
    var body: some View {
        CustText(text: profileViewModel.user?.name ?? "nick name", weight: .regular, size: 20)
        CustText(text: profileViewModel.user?.username ?? "nick name", weight: .regular, size: 14).foregroundColor(.gray).padding(.bottom, 5)
        HStack(){
            CustText(text: "\(String(profileViewModel.user!.subscriptions))\n following", weight: .thin, size: 14)      .multilineTextAlignment(.center)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
                .foregroundColor(.black)
            CustText(text: "\(String(profileViewModel.user!.subscribers))\n followers", weight: .thin, size: 14)
                .multilineTextAlignment(.center)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
                .foregroundColor(.black)
            CustText(text: "\(String(profileViewModel.user!.events))\n events", weight: .thin, size: 14)
                .multilineTextAlignment(.center)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
                .foregroundColor(.black)
        }
    }
}

struct SearchView: View{
    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 0) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            Text("search")
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.leading)
                .foregroundColor(.gray)
                .padding(.horizontal)
        }
    }
}

struct MyEventItemView: View {
    let event: EventItemModel
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            EventItemImage(imageUrl: event.imageLink)
                .padding(.bottom, 8)
            CustText(text: event.name, weight: .medium, size: 17)
        }
        .background(.white)
        .cornerRadius(10)
    }
}

struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage(profileViewModel: ProfileViewModel(
            apiManager: ProfileApiManager(
                webService: WebService(
                    keychainManager: KeychainManager()))))
    }
}
