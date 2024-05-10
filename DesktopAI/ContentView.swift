//
//  ContentView.swift
//  DesktopAI
//
//  Created by Kyle Rich on 5/9/24.
//

import SwiftUI
import SwiftData

class BaseModel {
    var name: String
    var provider: String

    init(name: String) {
        self.name = name
        self.provider = "Model"
    }
    func performAction() {}
}

class GroqModel: BaseModel {
    override func performAction() {
    
    }
}

struct APIResponse: Decodable {
    let object: String
    let data: [AIModel]
}

struct AIModel: Decodable {
    let id: String
    let active: Bool
}

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @State private var aiModels: [BaseModel] = []
    @AppStorage("apiKeyGrok") var apiKeyGrok: String = ""

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                    } label: {
                        Text("Item")
                    }
                    .contextMenu {
                        Button(action: {
                            
                        }) {
                            Text("Delete")
                            Image(systemName: "trash")
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
            .toolbar {
                ToolbarItem {
                    Menu {
    ForEach(Dictionary(grouping: aiModels, by: \.provider).sorted(by: { $0.key < $1.key }), id: \.key) { provider, models in
        Section(header: Text(provider)) {
            ForEach(models, id: \.name) { model in
                Button(action: {
                    addItem()
                }) {
                    Text(model.name)
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
        .onAppear(perform: fetchAIModels)
    }

    private func fetchAIModels() {
    guard let url = URL(string: "https://api.groq.com/openai/v1/models") else {
        print("Invalid URL")
        return
    }

    var request = URLRequest(url: url)
    request.setValue("Bearer \(apiKeyGrok)", forHTTPHeaderField: "Authorization")

    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        if let error = error {
            print("Error occurred: \(error)")
            return
        }

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            print("Server error: \(response)")
            return
        }

        guard let data = data else {
            print("No data received from server")
            return
        }

        do {
            let decoder = JSONDecoder()
            let decodedResponse = try decoder.decode(APIResponse.self, from: data)
            DispatchQueue.main.async {
                self.aiModels = decodedResponse.data.map { BaseModel(name: $0.id) }
            }
        } catch {
            print("Failed to decode JSON: \(error)")
        }
    }
    task.resume()
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
