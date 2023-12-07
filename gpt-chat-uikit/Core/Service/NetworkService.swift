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
    
    func sendMessage(
        messages: [Message],
        completion: @escaping CompletionHandler
    ) {
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Constants.apiKey)"
        ]
        
        let body = OpenAICompletionBody(
            model: "gpt-3.5-turbo",
            messages: messages
        )
        
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
