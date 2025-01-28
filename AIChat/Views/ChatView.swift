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
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 1)
                    )
                Button("Send") {
                    chatViewModel.sendMessage()
                }
            }
            .padding()
        }
    }
}

#Preview {
    ChatView()
}
