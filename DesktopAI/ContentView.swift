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
    @Query(sort: \Item.timestamp, order: .forward, animation: .spring) private var items: [Item]
    @State private var selectedItem: Item?
    @State private var groupedModels: [String: [AIModel]] = [:]
    private let providers: [BaseProvider] = [OpenAIProvider(), GroqProvider(),CloudflareAIProvider()]

    @AppStorage("apiKeyGrok") private var apiKeyGrok: String = ""
    @AppStorage("apiKeyOpenAI") var apiKeyOpenAI: String = ""
    @AppStorage("apiKeyCloudflareAIAccountId") var apiKeyCloudflareAIAccountId: String = ""
    @AppStorage("apiKeyCloudflareAIKey") var apiKeyCloudflareAIKey: String = ""

    var body: some View {
        NavigationSplitView {
            List(items) { item in
                NavigationLink(item.model, destination: DisplayChats(selectedItem: item))
                .contextMenu {
                    Button(action: {
                        withAnimation {
                            modelContext.delete(item)
                        }
                    }) {
                        Text("Delete")
                        Image(systemName: "trash")
                    }
                }
            }
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
            .toolbar {
                ToolbarItem {
                    Menu {
                        ForEach(groupedModels.sorted(by: { $0.key < $1.key }), id: \.key) { provider, models in
                            Section(header: Text(provider)) {
                                ForEach(models, id: \.id) { model in
                                    Button(action: {
                                        addItem(model: model.id)
                                    }) {
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
            if let selectedItem = selectedItem {
                DisplayChats(selectedItem: selectedItem)
            } else {
                Text("Select an item")
            }
        }
        .onAppear {
            fetchModels()
        }
        .onChange(of: apiKeyGrok) { _, _ in
            fetchModels()
        }
        .onChange(of: apiKeyOpenAI) { _, _ in
            fetchModels()
        }
        .onChange(of: apiKeyCloudflareAIAccountId) { _, _ in
            fetchModels()
        }
        .onChange(of: apiKeyCloudflareAIKey) { _, _ in
            fetchModels()
        }
    }

    private func fetchModels() {
        self.groupedModels = [:]
        
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

    private func addItem(model: String) {
        withAnimation {
            let newItem = Item(timestamp: Date(), model: model)
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
