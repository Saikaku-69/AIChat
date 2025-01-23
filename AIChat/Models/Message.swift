//
//  Message.swift
//  AIChat
//
//  Created by cmStudent on 2025/01/22.
//

import Foundation

struct Message: Identifiable {
    let id = UUID()
    let content: String
    let isUser: Bool //ユーザーとAIのMessageを区別するため
}
