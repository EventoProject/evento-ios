//
//  NetworkError.swift
//  Evento
//
//  Created by Ramir Amrayev on 13.04.2023.
//

import Combine

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case requestFailed(errorText: String)
    case incorrectJSON
    case encodingFailed
}
