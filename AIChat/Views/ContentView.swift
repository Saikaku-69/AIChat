//
//  ContentView.swift
//  AIChat
//
//  Created by cmStudent on 2025/01/22.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationStack {
            Text("Welcome!")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 5)
            
            NavigationLink(destination: ChatView()) {
                HStack {
                    Image("ai")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50)
                    Text("Chat")
                        .foregroundColor(.black)
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black,lineWidth: 1)
                )
            }
        }
    }
}

#Preview {
    ContentView()
}
