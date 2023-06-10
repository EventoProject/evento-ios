//
//  WebSocketManager.swift
//  Evento
//
//  Created by Ramir Amrayev on 10.06.2023.
//

import Foundation

final class WebSocketManager {
    private var webSocketTask: URLSessionWebSocketTask?
    
    var onMessageReceived: ((MessageModel) -> Void)?
    var onConnected: (() -> Void)?
    var onDisconnected: ((_ error: Error?) -> Void)?
    
    func connect(to url: URL) {
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
    
    private func receiveMessages() {
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
    
    private func handleMessage(_ message: URLSessionWebSocketTask.Message) {
        switch message {
        case .string(let text):
            if let data = text.data(using: .utf8) {
                do {
                    let messageModel = try JSONDecoder().decode(MessageModel.self, from: data)
                    onMessageReceived?(messageModel)
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
    
    private func disconnectWithError(_ error: Error?) {
        webSocketTask = nil
        onDisconnected?(error)
    }
}
