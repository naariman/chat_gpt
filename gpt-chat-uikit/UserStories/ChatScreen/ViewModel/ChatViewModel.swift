//
//  ChatViewModel.swift
//  gpt-chat-uikit
//
//  Created by Nariman on 27.11.2023.
//

import Foundation

final class ChatViewModel {
    private let networkService: NetworkService = .init()
    var chatMessages: [ChatMessage] = [] {
        didSet {
            self.onDataUpdate?()
        }
    }
    
    var onDataUpdate: (() -> Void)?
    
    func sendMessageToGPT(message: String) {
        networkService.sendMessage(message: message) { result in
            switch result {
            case .success(let model):
                let model = ChatMessage(
                    id: UUID().uuidString,
                    content: model.choices[0].text.replacingOccurrences(of: "\n\n", with: ""),
                    dateCreated: Date(),
                    messageSender: .gpt
                )
                self.chatMessages.append(model)
            case .failure(let error):
                print(error)
            }
            
        }
    }
}
