//
//  NetworkService.swift
//  gpt-chat-uikit
//
//  Created by Nariman on 27.11.2023.
//

import Foundation
import Alamofire

final class NetworkService {
    typealias CompletionHandler = (Result<OpenAICompletionResponse, Error>) -> Void
    
    func sendMessage(message: String, completion: @escaping CompletionHandler) {
        let body = OpenAICompletionBody(
            model: "gpt-3.5-turbo",
            prompt: message,
            temperature: 0.5,
            max_tokens: 50
        )
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Constants.apiKey)"
        ]
        
        AF.request(
            Constants.baseUrl + "completions",
            method: .post,
            parameters: body,
            encoder: .json,
            headers: headers
        ).responseDecodable(of: OpenAICompletionResponse.self) { response in
            switch response.result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
