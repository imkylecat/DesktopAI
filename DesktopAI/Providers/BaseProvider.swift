//
//  BaseProvider.swift
//  DesktopAI
//
//  Created by Kyle Rich on 5/10/24.
//

import Foundation

class BaseProvider {
    var name: String

    init() {
        self.name = "Base"
    }

    func getModels(completion: @escaping ([AIModel]?) -> Void) {}

    func userSentChatMessage(item: Item) -> Void {}
    
    func handleUserSentChatMessageResponse(item: Item, content: String) -> Void {
        DispatchQueue.main.async {
            let chatMessage = ChatMessage(content: content, isFromAI: true)
            item.chatHistory.append(chatMessage)
        }
    }
}
