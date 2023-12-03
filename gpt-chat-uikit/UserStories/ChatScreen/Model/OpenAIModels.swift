//
//  OpenAIModels.swift
//  gpt-chat-uikit
//
//  Created by Nariman on 27.11.2023.
//

import Foundation

struct OpenAICompletionBody: Codable {
    let model: String
    let messages: [Message]
}

struct Message: Codable {
    let role: String
    let content: String
}

struct OpenAICompletionResponse: Codable {
    let choices: [Choice]
}

struct Choice: Codable {
    let message: Message
}


