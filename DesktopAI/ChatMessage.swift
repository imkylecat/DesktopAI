//
//  ChatMessage.swift
//  DesktopAI
//
//  Created by Kyle Rich on 5/10/24.
//

import Foundation
import SwiftData

@Model
final class ChatMessage {
    var timestamp: Date
    var content: String
    var isFromAI: Bool
    @Relationship(deleteRule: .cascade) var item: Item?

    init(content: String, isFromAI: Bool, item: Item) {
        self.content = content
        self.isFromAI = isFromAI
        self.item = item
        self.timestamp = Date()
    }
}
