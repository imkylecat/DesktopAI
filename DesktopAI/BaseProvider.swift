//
//  BaseProvider.swift
//  DesktopAI
//
//  Created by Kyle Rich on 5/10/24.
//

import Foundation

class BaseProvider {
    var name: String
    var provider: String

    init(name: String, provider: String) {
        self.name = name
        self.provider = provider
    }
    func performAction() {}
}
