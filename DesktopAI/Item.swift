//
//  Item.swift
//  DesktopAI
//
//  Created by Kyle Rich on 5/9/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    @Relationship(deleteRule: .cascade, inverse: \ChatMessage.item)
    var chatHistory = [ChatMessage]()
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
