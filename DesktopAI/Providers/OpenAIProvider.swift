//
//  OpenAIProvider.swift
//  DesktopAI
//
//  Created by Kyle Rich on 5/10/24.
//

import Foundation
import SwiftUI
import SwiftData

class OpenAIProvider: BaseProvider {
    override init() {
        super.init()
        self.name = "OpenAI"
    }
    
    override func getModels(completion: @escaping ([AIModel]?) -> Void) {
        @AppStorage("apiKeyOpenAI") var apiKeyOpenAI: String = ""

        guard !apiKeyOpenAI.isEmpty else {
            return
        }

        completion([
            AIModel(id: "ChatGPT 3.5")
        ])
    }
}
