//
//  SettingsView.swift
//  DesktopAI
//
//  Created by Cole Legere on 5/10/24.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    private enum Tabs: Hashable {
        case general, apikeys, systemprompts
    }
    var body: some View {
        TabView {
            GeneralSettingsView()
                .tabItem {
                    Label("General", systemImage: "gear")
                }
                .tag(Tabs.general)
            APIKeysSettingsView()
                .tabItem {
                    Label("API Keys", systemImage: "key")
                }
                .tag(Tabs.apikeys)
            SystemPromptSettingsView()
                .tabItem {
                    Label("System Prompts", systemImage: "rectangle.and.pencil.and.ellipsis")
                }
                .tag(Tabs.systemprompts)
        }
        .padding(20)
        .frame(width: 800, height: 400)
    }
}
