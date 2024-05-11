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
    var model: String
    @Relationship(deleteRule: .cascade, inverse: \ChatMessage.item)
    var chatHistory = [ChatMessage]()
    
    init(timestamp: Date, model: String) {
        self.timestamp = timestamp
        self.model = model
    }
}
