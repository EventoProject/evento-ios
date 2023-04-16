//
//  URLRequest+Extensions.swift
//  Evento
//
//  Created by Ramir Amrayev on 13.04.2023.
//

import Foundation

//extension URLRequest {
//    var description: String {
//        guard let url = url?.absoluteString else {
//            return "Failed to get request URL"
//        }
//        
//        let method = httpMethod ?? "Unknown"
//        var curlCommand = "curl -X \(method) '\(url)'"
//        
//        if let headers = allHTTPHeaderFields {
//            for (key, value) in headers {
//                curlCommand += " -H '\(key): \(value)'"
//            }
//        }
//        
//        if let httpBody = httpBody, let bodyString = String(data: httpBody, encoding: .utf8) {
//            curlCommand += " -d '\(bodyString)'"
//        }
//        
//        return "Curl command:" + "\n" + curlCommand
//    }
//}
