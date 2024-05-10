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
        case general, apikeys
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
        }
        .padding(20)
        .frame(width: 375, height: 150)
    }
}
