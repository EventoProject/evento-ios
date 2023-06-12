//
//  EventViewModel.swift
//  Evento
//
//  Created by Ramir Amrayev on 24.05.2023.
//

import Foundation
import Combine

private enum Constants {
    static let avatarImageUrlKey = "avatarImageUrlKey"
}

final class EventViewModel: ObservableObject {
    // MARK: - Published parameters
    @Published var eventModel: EventResponseModel?
    @Published var selectedSegmentedControlItem = "Description"
    @Published var isAlertPresented = false
    @Published var commentModel = InputViewModel()
    @Published var shareMessage = ""
    
    // MARK: - Callbacks
    var showLikesPage: VoidCallback?
    var showCommentsPage: VoidCallback?
    var showWebPage: Callback<(url: String, title: String)>?
    
    // MARK: - Public parameters
    let segmentedControlItems = ["Description", "Details"]
    var alertMainText = ""
    var alertMessageText = ""
    let avatarImageUrl = UserDefaults.standard.string(forKey: Constants.avatarImageUrlKey) ?? ""
    var eventDate: Date? {
        eventModel?.date.toDate(with: .ddMMyyyyHHmm)
    }
    var eventDateText: String {
        eventDate?.toString(format: .ddMMyyyy) ?? ""
    }
    var eventTimeText: String {
        eventDate?.toString(format: .hhmm) ?? ""
    }
    var isShareAlert = false
    var alertConfirmButtonText = "OK"
    
    // MARK: - Private parameters
    private let eventId: Int
    private let apiManager: EventsApiManagerProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(eventId: Int, apiManager: EventsApiManagerProtocol) {
        self.eventId = eventId
        self.apiManager = apiManager
        
        getEvent()
    }
    
    func didTapLike(isLiked: Bool) {
        eventModel?.liked.toggle()
        
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.apiManager.like(isLike: isLiked, eventId: self.eventId).sink(
                receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        print(error)
                    }
                }, receiveValue: { [weak self] _ in
                    print("Successfully \(isLiked ? "liked" : "disliked")")
                    if isLiked {
                        self?.eventModel?.likes += 1
                    } else {
                        self?.eventModel?.likes -= 1
                    }
                }
            ).store(in: &self.cancellables)
        }
    }
    
    func didTapSave(isSaved: Bool) {
        eventModel?.saved.toggle()
        
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.apiManager.save(isSave: isSaved, eventId: self.eventId).sink(
                receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        print(error)
                    }
                }, receiveValue: { _ in
                    print("Successfully \(isSaved ? "saved" : "unsaved")")
                }
            ).store(in: &self.cancellables)
        }
    }
    
    func didTapParticipate() {
        showWebPage?((url: eventModel?.websiteLink ?? "", title: eventModel?.name ?? ""))
    }
    
    func didTapShare() {
        showAlert(mainText: "Enter your share message", isShareAlert: true)
    }
    
    func didTapLikeCountButton() {
        showLikesPage?()
    }
    
    func didTapCommentsCount() {
        showCommentsPage?()
    }
    
    func didTapSendComment() {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.apiManager.sendComment(
                text: self.commentModel.text,
                eventId: self.eventId
            ).sink(
                receiveCompletion: { [weak self] completion in
                    if case let .failure(error) = completion {
                        self?.showAlert(mainText: error.localizedDescription)
                    }
                },
                receiveValue: { [weak self] _ in
                    self?.showAlert(
                        mainText: "Your comment  successfully sended",
                        messageText: "You can see it if you tap on comments link"
                    )
                    self?.commentModel.text = ""
                    self?.eventModel?.comments += 1
                }
            ).store(in: &self.cancellables)
        }
    }
    
    func didTapAlertConfirmButton() {
        if isShareAlert {
            shareEvent()
        }
        isAlertPresented = false
    }
}

private extension EventViewModel {
    func getEvent() {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.apiManager.getEvent(id: self.eventId).sink(
                receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        print(error)
                    }
                },
                receiveValue: { [weak self] model in
                    self?.eventModel = model
                }
            ).store(in: &self.cancellables)
        }
    }
    
    func showAlert(
        mainText: String,
        messageText: String = "",
        isShareAlert: Bool = false
    ) {
        alertMainText = mainText
        alertMessageText = messageText
        self.isShareAlert = isShareAlert
        alertConfirmButtonText = isShareAlert ? "Share" : "OK"
        isAlertPresented = true
    }
    
    func shareEvent() {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.apiManager.share(text: self.shareMessage, eventId: self.eventId).sink(
                receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        print(error)
                    }
                }, receiveValue: { [weak self] _ in
                    self?.showAlert(mainText: "Event shared in your profile")
                }
            ).store(in: &self.cancellables)
        }
    }
}
