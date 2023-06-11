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

    init(profileViewModel: ProfileViewModel) {
        self.profileViewModel = profileViewModel
        self.imagePicker = ProfileImageView(viewModel: profileViewModel)
    }
    
    var body: some View {
        VStack{
            ZStack{
                RoundedRectangle(cornerRadius: 15)
                                .fill(Color.white)
                                .shadow(color: Color.gray.opacity(0), radius: 4, x: 0, y: 2)
                                .padding()
                VStack{
                    imagePicker
                    CustText(text: profileViewModel.user?.name ?? "nick name", weight: .regular, size: 20)
                    HStack(){
                        CustText(text: "\(String(profileViewModel.myevents.count))\n following", weight: .thin, size: 14)      .multilineTextAlignment(.center)
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                        CustText(text: "\(String(profileViewModel.myevents.count))\n followers", weight: .thin, size: 14)
                            .multilineTextAlignment(.center)
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                        CustText(text: "\(String(profileViewModel.myevents.count))\n events", weight: .thin, size: 14)
                            .multilineTextAlignment(.center)
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    
                    .background(.white)
                    .cornerRadius(10)
                    ZStack(alignment: .leading) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        Text("search")
                            .padding(.leading, 20)
                    }
                    .onTapGesture {
                        profileViewModel.ShowSearchPage()
                    }
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(15)
                    .padding()
                }
            }
            .background(CustColor.backgroundColor)
            VStack{
                List(profileViewModel.myevents, id: \.self) { event in
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
//struct SearchBar: View {
//    @Binding var text: String
//
//    var body: some View {
//        VStack {
//            ZStack(alignment: .leading) {
//                Image(systemName: "magnifyingglass")
//                    .foregroundColor(.gray)
//                TextField("search", text: $text)
//                    .padding(.leading, 20)
//            }
//            .padding()
//            .background(Color.gray.opacity(0.2))
//            .cornerRadius(15)
//            .padding()
//        }
//    }
//}
struct MyEventItemView: View {
    let event: EventItemModel
    var body: some View {
//        Button(
//            action: didTap,
//            label: {
                
                VStack(alignment: .leading, spacing: 0) {
                    EventItemImage(imageUrl: event.imageLink.string)
                        .padding(.bottom, 8)
                    CustText(text: event.name, weight: .medium, size: 17)
                }
//                .padding(10)
                .background(.white)
                .cornerRadius(10)
            }
//        )
//    }
}

struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage(profileViewModel: ProfileViewModel(
            apiManager: ProfileApiManager(
                webService: WebService(
                    keychainManager: KeychainManager())), eventApiManager: EventsApiManager(webService: WebService(keychainManager: KeychainManager()))))
    }
}
