//
//  GeneralSettingsView.swift
//  DesktopAI
//
//  Created by Cole Legere on 5/10/24.
//

import SwiftUI
import SwiftData

struct GeneralSettingsView: View {
    @AppStorage("isStreamEnabled") private var isStreamEnabled: Bool = false

    var body: some View {
        Form {
            Section(header: Text("General Settings")) {
                Toggle(isOn: $isStreamEnabled) {
                    Text("Streaming")
                }
                Text("Enable this to start streaming. Better known as the Typewritter effect")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
    }
}
