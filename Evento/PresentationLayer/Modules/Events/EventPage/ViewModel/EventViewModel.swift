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
    
    // MARK: - Callbacks
    var showLikesPage: VoidCallback?
    var showCommentsPage: VoidCallback?
    
    // MARK: - Public parameters
    let event: EventItemModel
    let segmentedControlItems = ["Description", "Details"]
    var alertMainText = ""
    var alertMessageText = ""
    let avatarImageUrl = UserDefaults.standard.string(forKey: Constants.avatarImageUrlKey) ?? ""
    var eventDate: Date? {
        event.date.toDate(with: .ddMMyyyyHHmm)
    }
    var eventDateText: String {
        eventDate?.toString(format: .ddMMyyyy) ?? ""
    }
    var eventTimeText: String {
        eventDate?.toString(format: .hhmm) ?? ""
    }
    
    // MARK: - Private parameters
    private let apiManager: EventsApiManagerProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(event: EventItemModel, apiManager: EventsApiManagerProtocol) {
        self.event = event
        self.apiManager = apiManager
        
        getEvent()
    }
    
    func didTapLike(isLiked: Bool) {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.apiManager.like(isLike: isLiked, eventId: self.event.id).sink(
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
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.apiManager.save(isSave: isSaved, eventId: self.event.id).sink(
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
        print("Participate button tapped")
    }
    
    func didTapShare() {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.apiManager.share(isShare: true, eventId: self.event.id).sink(
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
                eventId: self.event.id
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
}

private extension EventViewModel {
    func getEvent() {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.apiManager.getEvent(id: self.event.id).sink(
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
    
    func showAlert(mainText: String, messageText: String = "") {
        alertMainText = mainText
        alertMessageText = messageText
        isAlertPresented = true
    }
}
