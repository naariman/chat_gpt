//
//  OpenAIModels.swift
//  gpt-chat-uikit
//
//  Created by Nariman on 27.11.2023.
//

import Foundation

public struct OpenAICompletionBody: Codable {
    let model: String
    let prompt: String
    let temperature: Double
    let max_tokens: Double
}

public struct OpenAICompletionResponse: Codable {
    let id: String
    let choices: [OpenAICompletionChoice]
}

public struct OpenAICompletionChoice: Codable {
    let text: String
}


