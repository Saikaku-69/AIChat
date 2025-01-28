//
//  ChatViewModel.swift
//  AIChat
//
//  Created by cmStudent on 2025/01/22.
//

import Foundation
import Combine

class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = []
    @Published var inputText: String = ""
    private var client: OpenAIAPICaller = OpenAIAPICaller()
    
    
    func sendMessage() {
        guard !inputText.isEmpty else { return }
        
        let newMessage = Message(content: inputText, isUser: true)
        messages.append(newMessage)
        self.inputText = ""
        client.fetchResponse(prompt: inputText) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    if let content = response.choices.first?.message.content {
                        let aiMessage = Message(content: content, isUser: false)
                        self?.messages.append(aiMessage)
                    }
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }
}
