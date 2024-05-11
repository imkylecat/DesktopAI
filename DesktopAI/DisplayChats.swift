//
//  DisplayChats.swift
//  DesktopAI
//
//  Created by Cole Legere on 5/10/24.
//

import SwiftUI
import SwiftData

struct DisplayChats: View {
    let selectedItem: Item
    @State private var userMessage = ""
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Item at \(selectedItem.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                Spacer()
                Divider()
                TextField("Enter Message", text: $userMessage)
                    .padding([.trailing, .leading], 10)
            }
        }
    }
}
