//
//  DisplayChats.swift
//  DesktopAI
//
//  Created by Cole Legere on 5/10/24.
//

import Foundation
import SwiftUI
import SwiftData

struct DisplayChats: View {
    let selectedItem: Item
    @State private var userMessage = ""
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    ForEach(selectedItem.chatHistory.sorted(by: { $0.timestamp < $1.timestamp }), id: \.content) { message in
                        Text(message.content)
                            .padding(10)
                            .background(message.isFromAI ? Color.blue : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .frame(maxWidth: .infinity, alignment: message.isFromAI ? .leading : .trailing)
                            .padding(.bottom, 5)
                    }
                }
                HStack {
                    TextField("Enter Message", text: $userMessage, onCommit: {
                        let newMessage = ChatMessage(content: userMessage, isFromAI: false)
                        selectedItem.chatHistory.append(newMessage)
                        userMessage = ""

                        let provider = GroqProvider()
                        provider.chat(item: selectedItem)
                    })
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(5)
                }
                .background(Color.gray.opacity(0.1))
            }
        }
    }
}
