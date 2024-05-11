//
//  CloudflareAIProvider.swift
//  DesktopAI
//
//  Created by Kyle Rich on 5/10/24.
//

import Foundation
import SwiftUI
import SwiftData

class CloudflareAIProvider: BaseProvider {
    override init() {
        super.init()
        self.name = "Cloudflare AI"
    }
    
    override func getModels(completion: @escaping ([AIModel]?) -> Void) {
        @AppStorage("apiKeyCloudflareAIAccountId") var apiKeyCloudflareAIAccountId: String = ""
        @AppStorage("apiKeyCloudflareAIKey") var apiKeyCloudflareAIKey: String = ""

        guard !apiKeyCloudflareAIAccountId.isEmpty, !apiKeyCloudflareAIKey.isEmpty else {
            return
        }

        // Is there a API on Cloudflare to get these?
        completion([
            AIModel(id: "llama-2-7b-chat-fp16"),
            AIModel(id: "llama-2-7b-chat-int8"),
            AIModel(id: "mistral-7b-instruct-v0.1"),
            AIModel(id: "deepseek-coder-6.7b-base-awq"),
            AIModel(id: "deepseek-coder-6.7b-instruct-awq"),
            AIModel(id: "deepseek-math-7b-base"),
            AIModel(id: "deepseek-math-7b-instruct"),
            AIModel(id: "discolm-german-7b-v1-awq"),
            AIModel(id: "falcon-7b-instruct"),
            AIModel(id: "gemma-2b-it-lora"),
            AIModel(id: "gemma-7b-it"),
            AIModel(id: "gemma-7b-it-lora"),
            AIModel(id: "hermes-2-pro-mistral-7b"),
            AIModel(id: "llama-2-13b-chat-awq"),
            AIModel(id: "llama-2-7b-chat-hf-lora"),
            AIModel(id: "llama-3-8b-instruct"),
            AIModel(id: "llamaguard-7b-awq"),
            AIModel(id: "meta-llama-3-8b-instruct"),
            AIModel(id: "mistral-7b-instruct-v0.1-awq"),
            AIModel(id: "mistral-7b-instruct-v0.2"),
            AIModel(id: "mistral-7b-instruct-v0.2-lora"),
            AIModel(id: "neural-chat-7b-v3-1-awq"),
            AIModel(id: "openchat-3.5-0106"),
            AIModel(id: "openhermes-2.5-mistral-7b-awq"),
            AIModel(id: "phi-2"),
            AIModel(id: "qwen1.5-0.5b-chat"),
            AIModel(id: "qwen1.5-1.8b-chat"),
            AIModel(id: "qwen1.5-14b-chat-awq"),
            AIModel(id: "qwen1.5-7b-chat-awq"),
            AIModel(id: "sqlcoder-7b-2"),
            AIModel(id: "starling-lm-7b-beta"),
            AIModel(id: "tinyllama-1.1b-chat-v1.0"),
            AIModel(id: "una-cybertron-7b-v2-bf16"),
            AIModel(id: "zephyr-7b-beta-awq")
        ])
    }
}
