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
        @AppStorage("apiKeyGrok") var apiKeyGrok: String = ""

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
                let apiResponse = try JSONDecoder().decode(APIResponse.self, from: data)
                let aiModels = apiResponse.data.map { AIModel(id: $0.id) }
                completion(aiModels)
            } catch {
                print("Failed to decode JSON: \(error)")
                completion(nil)
            }
        }
        
        task.resume()
    }
}
