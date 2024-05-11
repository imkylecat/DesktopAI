//
//  DisplayChats.swift
//  DesktopAI
//
//  Created by Cole Legere on 5/10/24.
//

import Foundation
import SwiftUI
import SwiftData

struct ChatMessage {
    let content: String
    let isFromAI: Bool
}

struct DisplayChats: View {
    let selectedItem: Item
    @State private var userMessage = ""

    let chatMessages: [ChatMessage] = [
        ChatMessage(content: "Hello", isFromAI: false),
        ChatMessage(content: "How are you?", isFromAI: true),
        ChatMessage(content: "I'm good, thanks!", isFromAI: false),
        ChatMessage(content: "How about you?", isFromAI: true)
    ]
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    ForEach(chatMessages, id: \.content) { message in
                        Text(message.content)
                            .padding(10)
                            .background(message.isFromAI ? Color.gray : Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .frame(maxWidth: .infinity, alignment: message.isFromAI ? .trailing : .leading)
                            .padding(.bottom, 5)
                    }
                }
                HStack {
                    TextField("Enter Message", text: $userMessage)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(5)
                }
                .background(Color.gray.opacity(0.1))
            }
        }
    }
}
