//
//  APIKeysSettingsView.swift
//  DesktopAI
//
//  Created by Cole Legere on 5/10/24.
//

import SwiftUI
import SwiftData

struct APIKeysSettingsView: View {
    @State private var apiKeyGrok: String = ""

    var body: some View {
        Form {
            Section(header: Text("Platforms")) {
                TextField("Groq", text: $apiKey1)
            }
        }
        .padding()
    }
}