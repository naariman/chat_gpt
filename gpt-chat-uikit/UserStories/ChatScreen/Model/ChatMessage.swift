//
//  ChatMessage.swift
//  gpt-chat-uikit
//
//  Created by Nariman on 01.12.2023.
//

import Foundation
import MessageKit



struct MessageModel: MessageType {
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKit.MessageKind
    var image: UIImage?
}

struct SenderModel: SenderType {
    var senderId: String
    var displayName: String
}

