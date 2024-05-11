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
    var content: String
    var isFromAI: Bool
    var item: Item?

    init(content: String, isFromAI: Bool) {
        self.content = content
        self.isFromAI = isFromAI
    }
}
