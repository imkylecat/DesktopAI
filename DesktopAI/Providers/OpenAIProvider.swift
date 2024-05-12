//
//  OpenAIProvider.swift
//  DesktopAI
//
//  Created by Kyle Rich on 5/10/24.
//

import Foundation
import SwiftUI
import SwiftData

struct OpenAIModel: Decodable {
    let id: String
}

struct OpenAIAPIResponse: Decodable {
    let object: String
    let data: [OpenAIModel]
}

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

        guard let url = URL(string: "https://api.openai.com/v1/engines") else {
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer " + apiKeyOpenAI, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                completion(nil)
                return
            }
            
            do {
                let apiResponse = try JSONDecoder().decode(OpenAIAPIResponse.self, from: data)
                let aiModels = apiResponse.data.map { AIModel(id: $0.id) }.filter { $0.id.hasPrefix("gpt-") }
                completion(aiModels)
            } catch {
                print("Failed to decode JSON: \(error)")
                completion(nil)
            }
        }
        
        task.resume()
    }
}
