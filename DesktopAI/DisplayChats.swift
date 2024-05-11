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
        ZStack {
            VStack {
                ScrollView {
                    VStack {
                        Spacer()
                    }
                }
                HStack {
                    TextField("Enter Message", text: $userMessage)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(5)
                }
                .background(Color.gray.opacity(0.1))
            }
        }
    }
}
