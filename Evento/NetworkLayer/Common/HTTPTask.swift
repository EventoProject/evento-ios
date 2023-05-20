//
//  HTTPTask.swift
//  Evento
//
//  Created by Ramir Amrayev on 15.05.2023.
//

import Foundation

enum HTTPTask {
    case request
    case requestParameters(bodyParameters: [String: Any]?, urlParameters: [String: Any]?)
    case multipartFormData(bodyParameters: [String: Any]?, urlParameters: [String: Any]?)
    case requestJSONEncodable(Encodable)
}
