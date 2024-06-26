//
//  GroqProvider.swift
//  DesktopAI
//
//  Created by Kyle Rich on 5/10/24.
//

import Foundation
import SwiftUI
import SwiftData

struct GroqModel: Decodable {
    let id: String
}

struct GroqAPIResponse: Decodable {
    let object: String
    let data: [GroqModel]
}

struct Response: Codable {
    let choices: [Choice]
}

struct Choice: Codable {
    let message: Message
}

struct Message: Codable {
    let role: String
    let content: String
}

class GroqProvider: BaseProvider {
    override init() {
        super.init()
        self.name = "Groq"
    }
    
    override func getModels(completion: @escaping ([AIModel]?) -> Void) {
        @AppStorage("apiKeyGrok") var apiKeyGrok: String = ""

        guard !apiKeyGrok.isEmpty else {
            return
        }

        guard let url = URL(string: "https://api.groq.com/openai/v1/models") else {
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer " + apiKeyGrok, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                completion(nil)
                return
            }
            
            do {
                let apiResponse = try JSONDecoder().decode(GroqAPIResponse.self, from: data)
                let aiModels = apiResponse.data.map { AIModel(id: $0.id) }
                completion(aiModels)
            } catch {
                print("Failed to decode JSON: \(error)")
                completion(nil)
            }
        }
        
        task.resume()
    }

    override func userSentChatMessage(item: Item) -> Void {
        @AppStorage("apiKeyGrok") var apiKeyGrok: String = ""
        @AppStorage("modelSystemPrompt") var modelSystemPrompt: String = ""

        guard !apiKeyGrok.isEmpty else {
            return
        }

        guard let url = URL(string: "https://api.groq.com/openai/v1/chat/completions") else {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer " + apiKeyGrok, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        var messages = item.chatHistory.sorted { $0.timestamp < $1.timestamp }.map { ["role": $0.isFromAI ? "system" : "user", "content": $0.content] }
        if !modelSystemPrompt.isEmpty {
            let systemPrompt = ["role": "system", "content": modelSystemPrompt]
            messages.insert(systemPrompt, at: 0)
        }


        let requestBody: [String: Any] = [
            "max_tokens": 8192,
            "messages": messages,
            "model": item.model,
            "stop": NSNull(),
            "stream": false,
            "temperature": 1,
            "top_p": 1
        ]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: requestBody, options: [])
            request.httpBody = jsonData
        } catch {
            print("Failed to encode JSON: \(error)")
            return
        }

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                return
            }

            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(Response.self, from: data)
                
                if let firstChoice = response.choices.first {
                    print(firstChoice)
                    self.handleUserSentChatMessageResponse(item: item, content: firstChoice.message.content)
                }
            } catch {
                print("Failed to decode JSON: \(error)")
            }
        }

        task.resume()
    }
}
