//
//  ProfileTarget.swift
//  Evento
//
//  Created by Ramir Amrayev on 19.05.2023.
//

import UIKit

enum ProfileTarget {
    case uploadProfileImage(image: UIImage, hasImage: Bool)
    case getProfile
}

extension ProfileTarget: EndpointProtocol {
    var baseURL: String {
        return "http://localhost:8081/"
    }
    
    var path: String {
        switch self {
        case .uploadProfileImage:
            return "auth/profile/upload-image"
        case .getProfile:
            return "auth/profile"
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .uploadProfileImage:
            return .post
        case .getProfile:
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
