//
//  APIKeysSettingsView.swift
//  DesktopAI
//
//  Created by Cole Legere on 5/10/24.
//

import SwiftUI
import SwiftData

struct APIKeysSettingsView: View {
    @AppStorage("apiKeyGrok") private var apiKeyGrok: String = ""
    @AppStorage("apiKeyOpenAI") var apiKeyOpenAI: String = ""
    @AppStorage("apiKeyCloudflareAIAccountId") var apiKeyCloudflareAIAccountId: String = ""
    @AppStorage("apiKeyCloudflareAIKey") var apiKeyCloudflareAIKey: String = ""

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text("Groq")
                    .font(.headline)
                TextField("API Key", text: $apiKeyGrok)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Text("OpenAI")
                    .font(.headline)
                TextField("API Key", text: $apiKeyOpenAI)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Text("Cloudflare AI")
                    .font(.headline)
                TextField("Account ID", text: $apiKeyCloudflareAIAccountId)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("API Key", text: $apiKeyCloudflareAIKey)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding()
        }
    }
}