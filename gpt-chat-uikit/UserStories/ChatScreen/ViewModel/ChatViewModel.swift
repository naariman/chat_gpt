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
    var chatMessages: [MessageType] = [] {
        didSet {
            self.onDataUpdate?()
        }
    }
    let sender = SenderModel(
        senderId: "chatGPT",
        displayName: "ChatGPT"
    )
    
    var onDataUpdate: (() -> Void)?
    
    func sendMessageToGPT(message: String) {
        networkService.sendMessage(message: message) { result in
            switch result {
            case .success(let model):
                let model = MessageModel(
                    sender: self.sender,
                    messageId: UUID().uuidString,
                    sentDate: Date(),
                    kind: .text(model.choices[0].message.content.replacingOccurrences(of: "\n\n", with: ""))
                )
                self.chatMessages.append(model)
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
}
