//
//  EventPage.swift
//  Evento
//
//  Created by Ramir Amrayev on 24.05.2023.
//

import SwiftUI

struct EventPage: View {
    @ObservedObject var viewModel: EventViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            EventItemImage(imageUrl: viewModel.eventModel?.imageLink ?? "")
            NameLikeView(
                eventName: viewModel.eventModel?.name ?? "",
                isLiked: viewModel.eventModel?.liked ?? false,
                isSaved: viewModel.eventModel?.saved ?? false,
                didTapLike: { isLiked in
                    viewModel.didTapLike(isLiked: isLiked)
                },
                didTapSave: { isSaved in
                    viewModel.didTapSave(isSaved: isSaved)
                }
            )
            segmentedControlView
            if viewModel.selectedSegmentedControlItem == "Description" {
                CustText(text: viewModel.eventModel?.description ?? "", weight: .regular, size: 15)
                participateLikesView
            } else {
                detailsStackView
                Spacer()
                commentsView
                SendInputView(
                    inputModel: $viewModel.commentModel,
                    placeholder: "Add a comment...",
                    backgroundColor: CustColor.backgroundColor,
                    avatarImageUrl: viewModel.avatarImageUrl
                ) {
                    viewModel.didTapSendComment()
                }
            }
            Spacer()
        }
        .padding(20)
        .background(.white)
        .cornerRadius(20)
        .padding(20)
        .background(CustColor.backgroundColor)
        .alert(
            viewModel.alertMainText,
            isPresented: $viewModel.isAlertPresented
        ) {
            if viewModel.isShareAlert {
                TextField("Let's go together?", text: $viewModel.shareMessage)
            }
            HStack {
                if viewModel.isShareAlert {
                    Button("Cancel") {
                        viewModel.isAlertPresented = false
                    }
                }
                Button(viewModel.alertConfirmButtonText, action: viewModel.didTapAlertConfirmButton)
            }
        } message: {
            Text(viewModel.alertMessageText)
        }
    }
    
    private var segmentedControlView: some View {
        SegementedControlView(
            selectedItem: $viewModel.selectedSegmentedControlItem,
            items: viewModel.segmentedControlItems
        ).padding(.bottom, 20)
    }
    
    private var participateLikesView: some View {
        HStack(spacing: 10) {
            ButtonView(text: "Participate", type: .small) {
                viewModel.didTapParticipate()
            }
            ShareButton {
                viewModel.didTapShare()
            }
            Spacer()
            LikesCountButton(likesCount: viewModel.eventModel?.likes ?? 0) {
                viewModel.didTapLikeCountButton()
            }
        }.padding(.top)
    }
    
    private var commentsView: some View {
        HStack {
            CustText(text: "Comments", weight: .medium, size: 15)
            Spacer()
            Button(
                action: {
                    viewModel.didTapCommentsCount()
                },
                label: {
                    CustText(
                        text: "\(viewModel.eventModel?.comments ?? 0) comments",
                        weight: .medium,
                        size: 15
                    )
                    .foregroundColor(CustColor.lightGray)
                    .underline()
                }
            )
        }
    }
    
    private var detailsStackView: some View {
        VStack(alignment: .leading, spacing: 0.5) {
            DetailsView(title: "Format", value: viewModel.eventModel?.format)
            DetailsView(title: "Cost", value: viewModel.eventModel?.cost)
            DetailsView(title: "Date", value: viewModel.eventDateText)
            DetailsView(title: "Time", value: viewModel.eventTimeText)
            DetailsView(title: "Duration", value: viewModel.eventModel?.duration)
            DetailsView(title: "Age limit", value: viewModel.eventModel?.ageLimit)
        }
        .background { Color.gray }
        .padding(.top)
    }
}

private struct NameLikeView: View {
    let eventName: String
    var isLiked: Bool
    var isSaved: Bool
    let didTapLike: Callback<Bool>
    let didTapSave: Callback<Bool>
    
    var body: some View {
        HStack {
            CustText(text: eventName, weight: .semiBold, size: 16)
            Spacer()
            LikeButton(isLiked: isLiked, didTapLike: didTapLike)
            LikeButton(isLiked: isSaved, type: .save, didTapLike: didTapSave)
        }
        .padding(.top, 20)
        .padding(.bottom)
    }
}

private struct DetailsView: View {
    let title: String
    let value: String?
    
    var body: some View {
        HStack {
            Text("\(title): ")
                .font(MontserratFont.createFont(weight: .medium, size: 15))
            Spacer()
            Text(value ?? "")
                .font(MontserratFont.createFont(weight: .regular, size: 15))
        }
        .padding(5)
        .background(.white)
    }
}

private struct ShareButton: View {
    let didTap: VoidCallback
    
    var body: some View {
        Button(
            action: didTap,
            label: {
                Image(uiImage: Images.share)
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(CustLinearGradient, lineWidth: 1)
                    )
            }
        )
    }
}

private struct LikesCountButton: View {
    let likesCount: Int
    let didTap: VoidCallback
    
    var body: some View {
        Button(
            action: didTap,
            label: {
                HStack {
                    Image(uiImage: Images.likeFilled)
                        .frame(width: 20, height: 20)
                    CustText(text: "\(likesCount) Likes", weight: .regular, size: 16)
                        .foregroundColor(.black)
                }
            }
        )
    }
}

struct EventPage_Previews: PreviewProvider {
    static var previews: some View {
        EventPage(viewModel: EventViewModel(
            eventId: 3,
            apiManager: EventsApiManager(
                webService: WebService(
                    keychainManager: KeychainManager()
                )
            )
        ))
    }
}
