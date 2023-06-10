//
//  KeychainManager.swift
//  Evento
//
//  Created by Ramir Amrayev on 14.05.2023.
//

import Foundation

enum KeychainKeys: String, CaseIterable {
    case accessToken
    case userId
    case username
}

protocol KeychainManagerProtocol {
    // MARK: - Set Methods
    func set(value: String, type: KeychainKeys)
    
    // MARK: - Delete Methods
    func delete(type: KeychainKeys)
    func deleteAll()
    
    // MARK: - Get Methods
    func getString(type: KeychainKeys) -> String?
}

final class KeychainManager: KeychainManagerProtocol {
    // MARK: - Set Methods
    func set(value: String, type: KeychainKeys) {
        // Create a query dictionary with the necessary attributes
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: type.rawValue, // Unique identifier for the type
            kSecValueData as String: value.data(using: .utf8)!,
            kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlockedThisDeviceOnly // Specifies when the item is accessible
        ]
            
        // Delete any existing item with the same identifier
        SecItemDelete(query as CFDictionary)
            
        // Add type to the keychain
        let status = SecItemAdd(query as CFDictionary, nil)
            
        if status != errSecSuccess {
            print("Failed to save \(type.rawValue) to keychain")
        }
    }
    
    // MARK: - Delete Methods
    func delete(type: KeychainKeys) {
        // Create a query dictionary with the necessary attributes
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: type.rawValue // Unique identifier for the type
        ]
        
        // Delete type from the keychain
        let status = SecItemDelete(query as CFDictionary)
        
        if status != errSecSuccess {
            print("Failed to delete access \(type.rawValue) from keychain")
        }
    }
    
    func deleteAll() {
        for key in KeychainKeys.allCases {
            delete(type: key)
        }
    }
    
    // MARK: - Get Methods
    func getString(type: KeychainKeys) -> String? {
        // Create a query dictionary with the necessary attributes
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: type.rawValue, // Unique identifier for the type
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        if status == errSecSuccess, let data = result as? Data {
            return String(data: data, encoding: .utf8)
        } else {
            print("Failed to retrieve \(type.rawValue) from keychain")
            return nil
        }
    }
}
