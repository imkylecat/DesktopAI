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
    var id: UUID
    var timestamp: Date
    var model: String
    var provider: String
    
    @Relationship(deleteRule: .cascade) var chatHistory: [ChatMessage] = []
    
    init(timestamp: Date, model: String, provider: String) {
        self.id = UUID()
        self.timestamp = timestamp
        self.model = model
        self.provider = provider
    }
}
