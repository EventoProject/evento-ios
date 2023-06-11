//
//  WebSocketManager.swift
//  Evento
//
//  Created by Ramir Amrayev on 10.06.2023.
//

import Foundation

protocol WebSocketManagerProtocol {
    var onMessageReceived: Callback<MessageModel>? { get set }
    var onConnected: VoidCallback? { get set }
    var onDisconnected: Callback<Error?>? { get set }
    
    func connect(chatId: String, userId: Int, username: String)
    func disconnect()
    func sendMessage(_ message: String)
}

final class WebSocketManager: WebSocketManagerProtocol {
    private var webSocketTask: URLSessionWebSocketTask?
    
    var onMessageReceived: Callback<MessageModel>?
    var onConnected: VoidCallback?
    var onDisconnected: Callback<Error?>?
    
    func connect(chatId: String, userId: Int, username: String) {
        guard let url = formURL(chatId: chatId, userId: userId, username: username) else { return }
        let session = URLSession(configuration: .default)
        webSocketTask = session.webSocketTask(with: url)
        
        webSocketTask?.resume()
        receiveMessages()
        
        onConnected?()
    }
    
    func disconnect() {
        webSocketTask?.cancel(with: .normalClosure, reason: nil)
        webSocketTask = nil
        
        onDisconnected?(nil)
    }
    
    func sendMessage(_ message: String) {
        guard let webSocketTask = webSocketTask else {
            print("WebSocket task is not initialized")
            return
        }
        
        let messageData = URLSessionWebSocketTask.Message.string(message)
        webSocketTask.send(messageData) { error in
            if let error = error {
                print("Failed to send message: \(error)")
            }
        }
    }
}

private extension WebSocketManager {
    func receiveMessages() {
        guard let webSocketTask = webSocketTask else {
            print("WebSocket task is not initialized")
            return
        }
        
        webSocketTask.receive { [weak self] result in
            switch result {
            case .success(let message):
                self?.handleMessage(message)
                self?.receiveMessages() // Continue to receive next message
            case .failure(let error):
                self?.disconnectWithError(error)
            }
        }
    }
    
    func handleMessage(_ message: URLSessionWebSocketTask.Message) {
        switch message {
        case .string(let text):
            if let data = text.data(using: .utf8) {
                do {
                    let messageModel = try JSONDecoder().decode(MessageModel.self, from: data)
                    DispatchQueue.main.async { [weak self] in
                        self?.onMessageReceived?(messageModel)
                    }
                } catch {
                    print("Failed to decode message: \(error)")
                }
            }
        case .data(let data):
            print("Received binary data: \(data)")
        @unknown default:
            print("Received unknown message type")
        }
    }
    
    func disconnectWithError(_ error: Error?) {
        webSocketTask = nil
        onDisconnected?(error)
    }
    
    func formURL(chatId: String, userId: Int, username: String) -> URL? {
        guard var components = URLComponents(string: "ws://localhost:8081/ws/joinRoom/" + chatId) else {
            return nil
        }
        let urlParameters: [String: Any] = [
            "userId": userId,
            "username": username
        ]
        components.queryItems = urlParameters.map { URLQueryItem(name: $0.key, value: String(describing: $0.value)) }
        return components.url
    }
}
