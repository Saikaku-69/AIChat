//
//  MessageView.swift
//  AIChat
//
//  Created by cmStudent on 2025/01/22.
//

import SwiftUI

struct MessageView: View {
    let message: Message
    
    var body: some View {
        HStack {
            if message.isUser {
                Spacer()
            }
            Text(message.content)
                .padding()
                .background(message.isUser ? Color.blue : Color.gray)
                .foregroundColor(.white)
                .cornerRadius(10)
            
            if !message.isUser {
                Spacer()
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    MessageView(message: Message(content: "SampleMessage", isUser: true))
}
