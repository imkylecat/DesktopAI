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

    init(name: String) {
        self.name = name
    }
    func performAction() {
        
    }
}

class ModelChatGPT3_5: BaseModel {
    override func performAction() {
        // Define the action to be performed by Model1
    }
}

struct ChatBubble: Shape {
    var isFromCurrentUser: Bool
    var fixedHeight: CGFloat = 50

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let rect = CGRect(x: rect.minX, y: rect.minY, width: rect.width, height: fixedHeight)

        if isFromCurrentUser {
            path.addRoundedRect(in: rect.insetBy(dx: 0, dy: 10), cornerSize: CGSize(width: 10, height: 10))
            path.move(to: CGPoint(x: rect.width - 20, y: rect.height - 10))
            path.addLine(to: CGPoint(x: rect.width - 10, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width - 10, y: rect.height - 10))
        } else {
            path.addRoundedRect(in: rect.insetBy(dx: 0, dy: 10), cornerSize: CGSize(width: 10, height: 10))
            path.move(to: CGPoint(x: 20, y: rect.height - 10))
            path.addLine(to: CGPoint(x: 10, y: rect.height))
            path.addLine(to: CGPoint(x: 10, y: rect.height - 10))
        }

        return path
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
    @State private var inputText: String = ""
    @State private var isFromCurrentUser: Bool = false
    @AppStorage("apiKeyGrok") var apiKeyGrok: String = ""

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        VStack {
                            Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                            Spacer()
                            HStack {
                                if isFromCurrentUser {
                                    Spacer()
                                }
                                Text("Chat message")
                                    .padding(10)
                                    .background(ChatBubble(isFromCurrentUser: isFromCurrentUser).fill(Color.blue))
                                    .foregroundColor(.white)
                                if !isFromCurrentUser {
                                    Spacer()
                                }
                            }
                            TextField("Enter your message here", text: $inputText)
                                .padding()
                        }
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
                        ForEach(aiModels, id: \.name) { model in
                            Button(action: {
                                addItem()
                            }) {
                                Text(model.name)
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
