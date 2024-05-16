//
//  DisplayChats.swift
//  DesktopAI
//
//  Created by Cole Legere on 5/10/24.
//

import Foundation
import SwiftUI
import SwiftData

struct DisplayChatsView: View {
    @State private var userMessage = ""
    @Binding var selectedItemId: UUID?
    @Query private var items: [Item]

    var selectedItem: Item? {
        items.first(where: { $0.id == selectedItemId })
    }
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    ForEach(selectedItem?.chatHistory.sorted(by: { $0.timestamp < $1.timestamp }) ?? [], id: \.content) { message in
                        Text(message.content)
                            .padding(10)
                            .background(message.isFromAI ? Color(red: 0.2, green: 0.2, blue: 0.2) : Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .frame(maxWidth: .infinity, alignment: message.isFromAI ? .leading : .trailing)
                            .padding(.bottom, 5)
                    }
                }
                .padding()
                HStack {
                    TextField("Enter Message", text: $userMessage, onCommit: {
                        guard userMessage.count > 1 else {
                            return
                        }
                        
                        guard let selectedItem = selectedItem else {
                            return
                        }

                        let newMessage = ChatMessage(content: userMessage, isFromAI: false, item: selectedItem)
                        selectedItem.chatHistory.append(newMessage)
                        userMessage = ""

                        let provider: BaseProvider?
                        
                        switch selectedItem.provider {
                        case "Groq":
                            provider = GroqProvider()
                        case "OpenAI":
                            provider = OpenAIProvider()
                        case "CloudflareAI":
                            provider = CloudflareAIProvider()
                            
                        default:
                            return
                        }
                        
                        guard let provider = provider else {
                            return
                        }
                        
                        provider.userSentChatMessage(item: selectedItem)
                    })
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(5)
                }
                .background(Color.gray.opacity(0.1))
            }
        }
    }
}
