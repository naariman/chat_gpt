//
//  ChatMessage.swift
//  gpt-chat-uikit
//
//  Created by Nariman on 01.12.2023.
//

import Foundation

struct ChatMessage {
    let id: String
    let content: String
    let dateCreated: Date
    let messageSender: MessageSender
}

enum MessageSender {
    case user
    case gpt
}

extension ChatMessage {
    static let sampleMessages = [
        ChatMessage(
            id: UUID().uuidString,
            content: "Sample Message From me",
            dateCreated: Date(),
            messageSender: .user
        ),
        ChatMessage(
            id: UUID().uuidString,
            content: "Sample Message From gpt",
            dateCreated: Date(),
            messageSender: .gpt
        ),
        ChatMessage(
            id: UUID().uuidString,
            content: "Sample Message From me",
            dateCreated: Date(),
            messageSender: .user
        ),
        ChatMessage(
            id: UUID().uuidString,
            content: "Sample Message From gpt",
            dateCreated: Date(),
            messageSender: .gpt
        ),
    ]
}

