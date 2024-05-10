//
//  GroqProvider.swift
//  DesktopAI
//
//  Created by Kyle Rich on 5/10/24.
//

import Foundation

struct GroqModel: Decodable {
    let id: String
}

struct APIResponse: Decodable {
    let object: String
    let data: [GroqModel]
}

class GroqProvider: BaseProvider {
    override init() {
        super.init()
        self.name = "Groq"
    }
    
    override func getModels(completion: @escaping ([AIModel]?) -> Void) {
        completion([
            AIModel(id: "a")
        ])
    }
}
