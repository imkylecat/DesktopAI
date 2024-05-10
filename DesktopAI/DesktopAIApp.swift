//
//  DesktopAIApp.swift
//  DesktopAI
//
//  Created by Kyle Rich on 5/9/24.
//

import SwiftUI
import SwiftData

@main
struct DesktopAIApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        Settings {
            SettingsView()
        }
        .modelContainer(sharedModelContainer)
    }
}
