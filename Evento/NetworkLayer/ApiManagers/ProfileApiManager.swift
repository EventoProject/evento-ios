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
    func getProfile() -> AnyPublisher<UserModel, NetworkError>
}

final class ProfileApiManager: ProfileApiManagerProtocol {
    private let webService: WebServiceProtocol
    
    init(webService: WebServiceProtocol) {
        self.webService = webService
    }
    
    func uploadProfileImage(image: UIImage, hasImage: Bool) -> AnyPublisher<UploadProfileImageResponseModel, NetworkError> {
        webService.request(ProfileTarget.uploadProfileImage(image: image, hasImage: hasImage))
    }
    func getProfile() -> AnyPublisher<UserModel, NetworkError> {
        webService.request(ProfileTarget.getProfile)
    }
}

