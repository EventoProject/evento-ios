//
//  BaseProviderType.swift
//  Evento
//
//  Created by Ramir Amrayev on 13.04.2023.
//

import Foundation

protocol EndpointProtocol {
    var baseURL: String { get }
    var path: String { get }
    var method: HttpMethod { get }
    var headers: [String: String]? { get }
    var task: HTTPTask { get }
}
