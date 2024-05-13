//
//  SystemPrompts.swift
//  DesktopAI
//
//  Created by Cole Legere on 5/12/24.
//

import SwiftUI
import SwiftData

struct SystemPromptSettingsView: View {
    var body: some View {
        HSplitView {
            VStack {
                Text("Test")
                    .frame(width: 200, height: 300)
                    .border(Color.black, width: 1)
                HStack {
                    Button(action: {
                        print("Plus")
                    }) {
                        Image(systemName: "plus")
                    }
                    Button(action: {
                        print("minus")
                    }) {
                        Image(systemName: "minus")
                    }
                }
            }
        }
    }
}
