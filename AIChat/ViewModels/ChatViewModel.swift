//
//  ChatViewModel.swift
//  AIChat
//
//  Created by cmStudent on 2025/01/22.
//

import Foundation
import OpenAISwift

class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = []
    @Published var inputText: String = ""
    private var client: OpenAISwift?
    
    init() {
        if let apiKey = PlistManager.shared.getValue(forKey: "apiKey", fromPlist: "Config") as? String {
            client = OpenAISwift(config: OpenAISwift.Config.makeDefaultOpenAI(apiKey: apiKey))
        } else {
            print("Failed")
            client = OpenAISwift(config: OpenAISwift.Config.makeDefaultOpenAI(apiKey: ""))
        }
    }
    
    func sendMessage(_ content: String) {
        let userMessage = Message(content: content, isUser: true)
        messages.append(userMessage)
        //OpenAIクライアントに発送 //.gpt3(.davinci)はAIモデル。
        client?.sendCompletion(with: content, model: .gpt3(.davinci), maxTokens: 100) { result in
            switch result {
            case .success(let success):
                print("API Test: \(success)")
                //メインスレッドで進行するため
                DispatchQueue.main.async {
                    let aiMessage = Message(content: success.choices?.first?.text ?? "", isUser: false)
                    self.messages.append(aiMessage)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        if client == nil {
            print("OpenAI client is nil. Check apiKey initialization.")
        }
    }
}
