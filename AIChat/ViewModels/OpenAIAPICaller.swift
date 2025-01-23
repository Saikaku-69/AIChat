//
//  OpenAIAPICaller.swift
//  AIChat
//
//  Created by cmStudent on 2025/01/23.
//

import Foundation

struct Choice:Decodable {
    let message: MessageBox
}

struct ResponseModel: Decodable {
    let choices: [Choice]
}

struct MessageBox: Decodable {
    let content: String
}

class OpenAIAPICaller {
    private let apiKey: String =
    "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"
    
    private let baseURL = "https://api.openai.com/v1/chat/completions"
    
    func fetchResponse(prompt: String, completion: @escaping (Result<ResponseModel, Error>) -> Void) {
        guard let url = URL(string: baseURL) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "model": "gpt-4o",
            "messages": [
                ["role": "user", "content": prompt]
            ],
            "max_tokens": 100,
            "temperature":0.7
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            completion(.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -1, userInfo: nil)))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(ResponseModel.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
            
        }
        task.resume()
    }
}
