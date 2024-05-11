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
                    ForEach(selectedItem.chatHistory, id: \.content) { message in
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
