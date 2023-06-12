//
//  ProfileTarget.swift
//  Evento
//
//  Created by Ramir Amrayev on 19.05.2023.
//

import UIKit

enum ProfileTarget {
    case uploadProfileImage(image: UIImage, hasImage: Bool)
    case getProfile(id: Int)
    case getUsersSharedEvents(id: Int)
    case myEvents
    case subscriptions
    case subscribers
    case getMyProfile
    case searchUsers
    case getMySharedEvents
}

extension ProfileTarget: EndpointProtocol {
    var baseURL: String {
        return ApiConstants.baseURL
    }
    
    var path: String {
        switch self {
        case .uploadProfileImage:
            return "auth/profile/image"
        case let .getProfile(id):
            return "auth/profile/\(id)"
        case .getMyProfile:
            return "auth/profile"
        case .searchUsers:
            return "auth/search/users"
        case let .getUsersSharedEvents(id):
            return "auth/shared-events/\(id)"
        case .myEvents:
            return "auth/my-events"
        case .subscribers:
            return "auth/subscribers"
        case .subscriptions:
            return "auth/subscriptions"
        case .getMySharedEvents:
            return "auth/shared-events"
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .uploadProfileImage:
            return .post
        case .getProfile, .getMyProfile, .searchUsers, .myEvents, .subscribers, .subscriptions, .getUsersSharedEvents, .getMySharedEvents:
            return .get
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return nil
        }
    }
    
    var task: HTTPTask {
        switch self {
        case let .uploadProfileImage(image, hasImage):
            let bodyParams: [String: Any] = [
                "has_image": hasImage,
                "image_base64": image.toBase64String()
            ]
            return .requestParameters(bodyParameters: bodyParams, urlParameters: nil)
        default :
            return .request
        }
    }
}
