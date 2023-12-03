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

