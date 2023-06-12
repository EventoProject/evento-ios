//
//  ProfileManager.swift
//  Evento
//
//  Created by Ramir Amrayev on 19.05.2023.
//

import UIKit
import Combine

protocol ProfileApiManagerProtocol {
    func uploadProfileImage(image: UIImage, hasImage: Bool) -> AnyPublisher<UploadProfileImageResponseModel, NetworkError>
    func getProfile(id: Int) -> AnyPublisher<ProfileModel, NetworkError>
    func getMyProfile() -> AnyPublisher<MyProfileModel, NetworkError>
    func getSharedEvents() -> AnyPublisher<[ShareItemModel] , NetworkError>
    func getUserSharedEvents(userID: Int) -> AnyPublisher<[ShareItemModel], NetworkError>
    func getUsers() -> AnyPublisher<SearchUsersResponseModel, NetworkError>
}

final class ProfileApiManager: ProfileApiManagerProtocol {

    func getUsers() -> AnyPublisher<SearchUsersResponseModel, NetworkError> {
        webService.request(ProfileTarget.searchUsers)
    }
    
    private let webService: WebServiceProtocol
    
    init(webService: WebServiceProtocol) {
        self.webService = webService
    }
    
    func uploadProfileImage(image: UIImage, hasImage: Bool) -> AnyPublisher<UploadProfileImageResponseModel, NetworkError> {
        webService.request(ProfileTarget.uploadProfileImage(image: image, hasImage: hasImage))
    }
    
    func getMyProfile() -> AnyPublisher<MyProfileModel, NetworkError> {
        webService.request(ProfileTarget.getMyProfile)
    }
    
    func getProfile(id: Int) -> AnyPublisher<ProfileModel, NetworkError> {
        webService.request(ProfileTarget.getProfile(id: id))
    }
    
    func getSharedEvents() -> AnyPublisher<[ShareItemModel], NetworkError> {
        webService.request(ProfileTarget.getMySharedEvents)
    }
    
    func getUserSharedEvents(userID: Int) -> AnyPublisher<[ShareItemModel], NetworkError> {
        webService.request(ProfileTarget.getUsersSharedEvents(id: userID))
    }
    
}

