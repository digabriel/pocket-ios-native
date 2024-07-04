//
//  WalletCategory.swift
//  
//
//  Created by Dimas Gabriel on 7/4/24.
//

import SwiftData

@Model public class WalletCategory {
    enum Value: String, Codable, CaseIterable {
        case spending
        case savings
        case debt
    }

    let value: Value

    init(value: Value) {
        self.value = value
    }
}
