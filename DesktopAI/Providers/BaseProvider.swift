//
//  BaseProvider.swift
//  DesktopAI
//
//  Created by Kyle Rich on 5/10/24.
//

import Foundation

class BaseProvider {
    var name: String

    init() {
        self.name = "Base"
    }

    func getModels(completion: @escaping ([AIModel]?) -> Void) {
    }

    func chat(item: Item) -> Void {}
}
