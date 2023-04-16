//
//  BaseProviderType.swift
//  Evento
//
//  Created by Ramir Amrayev on 13.04.2023.
//

import Foundation

protocol BaseProviderType {
    var baseURL: String { get }
    var path: String { get }
    var method: HttpMethod { get }
    var headers: [String: String]? { get }
    var body: Data? { get }
    var parameters: [String: Any]? { get }
}
