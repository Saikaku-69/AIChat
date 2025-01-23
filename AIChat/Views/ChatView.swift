//
//  ChatView.swift
//  AIChat
//
//  Created by cmStudent on 2025/01/22.
//

import SwiftUI

struct ChatView: View {
    @StateObject var chatViewModel = ChatViewModel()
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack {
                    ForEach(chatViewModel.messages) { message in
                        MessageView(message: message)
                    }
                }
            }
            
            HStack {
                TextField("Type a message", text: $chatViewModel.inputText)
                Button("Send") {
                    chatViewModel.sendMessage()
                    chatViewModel.inputText = ""
                }
            }
            .padding()
        }
    }
}

#Preview {
    ChatView()
}
