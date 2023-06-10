//
//  EventPage.swift
//  Evento
//
//  Created by Ramir Amrayev on 24.05.2023.
//

import SwiftUI

struct EventPage: View {
    @ObservedObject var viewModel: EventViewModel
    private var event: EventItemModel {
        viewModel.event
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            EventItemImage(imageUrl: event.imageLink.string)
            NameLikeView(
                eventName: event.name,
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
                CustText(text: event.description, weight: .regular, size: 15)
                participateLikesView
            } else {
                detailsStackView
                Spacer()
                commentsView
                AddCommentView(
                    commentModel: $viewModel.commentModel,
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
        Picker("", selection: $viewModel.selectedSegmentedControlItem) {
            ForEach(viewModel.segmentedControlItems, id: \.self) {
                Text($0)
            }
        }
        .pickerStyle(.segmented)
        .padding(.bottom, 20)
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
            DetailsView(title: "Format", value: event.format)
            DetailsView(title: "Cost", value: event.cost)
            DetailsView(title: "Date", value: viewModel.eventDateText)
            DetailsView(title: "Time", value: viewModel.eventTimeText)
            DetailsView(title: "Duration", value: event.duration)
            DetailsView(title: "Age limit", value: event.ageLimit)
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
    let value: String
    
    var body: some View {
        HStack {
            Text("\(title): ")
                .font(MontserratFont.createFont(weight: .medium, size: 15))
            Spacer()
            Text(value)
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

struct AddCommentView: View {
    @Binding var commentModel: InputViewModel
    let avatarImageUrl: String
    var didTapSend: VoidCallback?
    
    var body: some View {
        HStack {
            AsyncAvatarImage(url: avatarImageUrl, size: 40)
            InputView(
                model: $commentModel,
                placeholder: "Add a comment ...",
                rightIcon: Images.send,
                backgroundColor: CustColor.backgroundColor,
                didTapRightIcon: {
                    didTapSend?()
                }
            )
        }
    }
}

struct EventPage_Previews: PreviewProvider {
    static var previews: some View {
        EventPage(viewModel: EventViewModel(
            event:
                EventItemModel(
                    id: 3,
                    name: "IT forum - Digital Almaty",
                    description: "Beeline Kazakhstan annual IT conference for engineers, developers, product managers, QA specialists, agile coaches, scrum masters and other dev specialists. The Conference is being held for the third time. This year, participants will learn all about the Kazakh code in four streams.",
                    format: "Offline",
                    cost: "Free",
                    date: "23.05.2023 20:44",
                    duration: "2 hours",
                    ageLimit: "16+",
                    imageLink: ImageLinkModel(
                        string: "https://evento-kz.s3.eu-north-1.amazonaws.com/events/f33d921c-6760-48b2-9d2a-75082410ec4c.jpg",
                        valid: true
                    ),
                    createdAt: "2023-05-23T14:45:17.24142Z",
                    isLiked: false
                ),
            apiManager: EventsApiManager(
                webService: WebService(
                    keychainManager: KeychainManager()
                )
            )
        ))
    }
}
