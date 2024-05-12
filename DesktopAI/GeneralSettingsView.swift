//
//  GeneralSettingsView.swift
//  DesktopAI
//
//  Created by Cole Legere on 5/10/24.
//

import SwiftUI
import SwiftData

struct GeneralSettingsView: View {
    @AppStorage("isModelResponseStreamingEnabled") private var isModelResponseStreamingEnabled: Bool = false
    @AppStorage("modelSystemPrompt") private var modelSystemPrompt: String = ""

    var body: some View {
        VStack(alignment: .leading) {
            Section() {
                Toggle(isOn: $isModelResponseStreamingEnabled) {
                    Text("Response Streaming")
                }
                Text("Enables real-time streaming of AI responses, known as the \"Typewriter effect\".")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Section(header: Text("System Prompts")) {
                TextField("System Prompt", text: $modelSystemPrompt)
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
    }
}
