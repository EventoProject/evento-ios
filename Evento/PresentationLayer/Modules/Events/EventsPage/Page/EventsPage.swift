//
//  EventsPage.swift
//  Evento
//
//  Created by Ramir Amrayev on 01.05.2023.
//

import SwiftUI

struct EventsPage: View {
    @ObservedObject var viewModel: EventsViewModel
    
    var body: some View {
        List(viewModel.events, id: \.self) { event in
            EventItemView(
                event: event,
                didTapLike: { isLiked in
                    viewModel.didTapLike(event: event, isLiked: isLiked)
                },
                didTap: {
                    viewModel.didTap(event: event)
                }
            )
            .listRowSeparator(.hidden)
            .listRowBackground(CustColor.backgroundColor)
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .background(CustColor.backgroundColor)
    }
}

private struct EventItemView: View {
    let event: EventItemModel
    let didTapLike: Callback<Bool>
    let didTap: VoidCallback
    
    var body: some View {
        Button(
            action: didTap,
            label: {
                VStack(alignment: .leading, spacing: 0) {
                    EventItemImage(imageUrl: event.imageLink.string)
                    CustText(text: event.name, weight: .medium, size: 17)
                    LikeStackView(event: event, didTapLike: didTapLike)
                    CustText(text: event.description, weight: .regular, size: 14)
                        .lineLimit(2)
                }
                .padding(20)
                .background(.white)
                .cornerRadius(20)
            }
        )
    }
    
    private struct EventItemImage: View {
        let imageUrl: String
        private let imageWidth = UIScreen.screenWidth - 94
        private let imageHeight = 0.6 * (UIScreen.screenWidth - 94)
        
        var body: some View {
            AsyncImage(
                url: URL(string: imageUrl),
                content: { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(
                            width: imageWidth,
                            height: imageHeight
                        )
                        .cornerRadius(20)
                },
                placeholder: {
                    CustColor.backgroundColor
                        .frame(
                            width: imageWidth,
                            height: imageHeight
                        )
                        .cornerRadius(20)
                }
            )
            .padding(.bottom, 8)
        }
    }
    
    private struct LikeStackView: View {
        let event: EventItemModel
        @State var isLiked: Bool
        let didTapLike: Callback<Bool>
        
        init(event: EventItemModel, didTapLike: @escaping Callback<Bool>) {
            self.event = event
            isLiked = false
            self.didTapLike = didTapLike
        }
        
        var body: some View {
            HStack {
                CustText(
                    text: "\(event.format) - \(event.cost) - \(event.date)",
                    weight: .regular,
                    size: 14
                )
                .foregroundColor(CustColor.lightGray)
                Spacer()
                Button(
                    action: {
                        isLiked.toggle()
                        didTapLike(isLiked)
                    },
                    label: {
                        Group {
                            if isLiked {
                                Image(uiImage: Images.likeFilled)
                            } else {
                                Image(uiImage: Images.like)
                            }
                        }
                        .frame(width: 25, height: 25)
                    }
                )
            }
            .padding(.bottom, 10)
        }
    }
}

struct EventsPage_Previews: PreviewProvider {
    static var previews: some View {
        EventsPage(viewModel: EventsViewModel(
            apiManager: EventsApiManager(
                webService: WebService(
                    keychainManager: KeychainManager()
                )
            )
        ))
    }
}
