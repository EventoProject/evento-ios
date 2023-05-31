//
//  OnboardingApiManager.swift
//  Evento
//
//  Created by Ramir Amrayev on 13.05.2023.
//

import Foundation
import Combine

struct VoidResponse: Codable, Hashable {
}

protocol OnboardingApiManagerProtocol {
    func login(email: String, password: String) -> AnyPublisher<LoginResponseModel, NetworkError>
    func register(payload: RegisterPayload) -> AnyPublisher<UserModel, NetworkError>
}

final class OnboardingApiManager: OnboardingApiManagerProtocol {
    
    private let webService: WebServiceProtocol
    
    init(webService: WebServiceProtocol) {
        self.webService = webService
    }
    
    func login(email: String, password: String) -> AnyPublisher<LoginResponseModel, NetworkError> {
        webService.request(OnboardingTarget.login(email: email, password: password))
    }
    
    func register(payload: RegisterPayload) -> AnyPublisher<UserModel, NetworkError> {
        webService.request(OnboardingTarget.register(payload: payload))
    }
}
