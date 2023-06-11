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
    case getMyProfile
    case searchUsers
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
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .uploadProfileImage:
            return .post
        case .getProfile, .getMyProfile, .searchUsers:
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
