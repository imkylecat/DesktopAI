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

    var body: some View {
        Form {
            Section(header: Text("Providers")) {
                TextField("Groq", text: $apiKeyGrok)
            }
        }
        .padding()
    }
}