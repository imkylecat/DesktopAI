//
//  ContentView.swift
//  DesktopAI
//
//  Created by Kyle Rich on 5/9/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @State private var groupedModels: [String: [AIModel]] = [:]
    private let providers: [BaseProvider] = [GroqProvider()]

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                    } label: {
                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
            .toolbar {
                ToolbarItem {
                    Menu {
                        ForEach(groupedModels.sorted(by: { $0.key < $1.key }), id: \.key) { provider, models in
                            Section(header: Text(provider)) {
                                ForEach(models, id: \.id) { model in
                                    Button(action: addItem) {
                                        Text(model.id)
                                    }
                                }
                            }
                        }
                    } label: {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
        .onAppear {
            fetchModels()
        }
    }

    private func fetchModels() {
        for provider in providers {
            provider.getModels { fetchedModels in
                if let fetchedModels = fetchedModels {
                    DispatchQueue.main.async {
                        self.groupedModels[provider.name] = fetchedModels
                    }
                }
            }
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
