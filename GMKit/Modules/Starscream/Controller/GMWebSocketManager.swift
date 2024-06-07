//
//  GMStarscreamController.swift
//  GMKit
//
//  Created by hule on 2024/6/7.
//

import UIKit

class GMWebSocketManager: WebSocketDelegate  {
    

    static let shared = GMWebSocketManager()
    private var socket: WebSocket?
    private var isConnected = false
    private var isManuallyDisconnected = false
    private let reconnectInterval: TimeInterval = 5 // 重连间隔时间（秒）
    private var pingTimer: Timer?
    
    private init() {
        let url = URL(string: "ws://47.119.173.119:3006/")! // 设置为你的服务器地址
        var request = URLRequest(url: url)
        request.timeoutInterval = 5
        socket = WebSocket(request: request)
        socket?.delegate = self
        self.setupHeartbeat()
    }
    
    func connect() {
        isManuallyDisconnected = false
        socket?.connect()
    }
    
    func disconnect() {
        isManuallyDisconnected = true
        pingTimer?.invalidate()
        socket?.disconnect()
    }
    
    private func setupHeartbeat() {
        pingTimer = Timer.scheduledTimer(withTimeInterval: 25, repeats: true) { [weak self] _ in
            self?.sendPing()
        }
    }
    
    private func sendPing() {
        socket?.write(ping: Data()) {
            print("Ping sent to server")
        }
    }
    
    private func attemptReconnect() {
        guard !isManuallyDisconnected else { return }
        
        DispatchQueue.global().asyncAfter(deadline: .now() + reconnectInterval) {
            // 你可以在这里添加更复杂的重连逻辑，例如重连次数限制
            print("Attempting to reconnect to WebSocket...")
            self.connect()
        }
    }
    
    
    //发送信息
    func writeText(message: String) {
        socket?.write(string: message, completion: {
            print("我发送了文字信息-->>\(message)")
        })
    }
    
    
    // MARK: - WebSocketDelegate Methods
    func didReceive(event: Starscream.WebSocketEvent, client: any Starscream.WebSocketClient) {
        switch event {
        case .connected(let headers):
            isConnected = true
            print("WebSocket 已连接: \(headers)")
            pingTimer?.fire()
            
        case .disconnected(let reason, let code):
            isConnected = false
            print("WebSocket 已断开连接: \(reason) 带有代码: \(code)")
            pingTimer?.invalidate()
            attemptReconnect()
            
        case .text(let string):
            print("收到文字: \(string)")
            
        case .binary(let data):
            print("收到数据: \(data.count) 字节")
            
        case .ping(_):
            // 当收到服务器的 ping 时，我们可以回送一个 pong
            client.write(pong: Data())
            
        case .pong(_):
            // 如果需要，处理 pong 响应
            break
            
        case .error(let error):
            isConnected = false
            handleError(error)
            pingTimer?.invalidate()
            attemptReconnect()
            
        default:
            break
        }
    }
    
    

    private func handleError(_ error: Error?) {
        if let e = error as? WSError {
            print("WebSocket 遇到了一个错误: \(e.message)")
        } else if let e = error {
            print("WebSocket 遇到了一个错误: \(e.localizedDescription)")
        } else {
            print("WebSocket 遇到了一个未知的错误")
        }
    }


    // Handle other events and errors
}
