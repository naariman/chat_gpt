//
//  ChatViewModel.swift
//  gpt-chat-uikit
//
//  Created by Nariman on 27.11.2023.
//

import Foundation
import MessageKit

final class ChatViewModel {
    private let networkService: NetworkService = .init()
    var UIchatMessages: [MessageType] = [] {
        didSet {
            self.onDataUpdate?()
        }
    }
    
    var chatMessages: [Message] = [] {
        didSet {
            self.onDataUpdate?()
        }
    }
    
    let sender = SenderModel(
        senderId: "chatGPT",
        displayName: "ChatGPT"
    )
    
    var onDataUpdate: (() -> Void)?
    
    func sendMessageToGPT(message: [Message]) {
        networkService.sendMessage(messages: message) { result in
            switch result {
            case .success(let model):
                let newModel = model.choices.last?.message
                self.chatMessages.append(
                    newModel ?? .init(role: "user", content: "bye")
                )
                
                let modelForUI = MessageModel(
                    sender: self.sender,
                    messageId: UUID().uuidString,
                    sentDate: Date(),
                    kind: .text(model.choices.last?.message.content ?? "")
                )
                self.UIchatMessages.append(modelForUI)

            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
}
