//
//  WalletCategory.swift
//  
//
//  Created by Dimas Gabriel on 7/4/24.
//

public enum WalletCategory: Int, CaseIterable, Sendable {
    case spending = 0
    case savings = 1
    case debt = 2

    public var name: String {
        switch self {
        case .spending:
            String(localized: "Spending")
        case .savings:
            String(localized: "Savings")
        case .debt:
            String(localized: "Debt")
        }
    }
}

extension WalletCategory: Comparable {
    public static func < (lhs: WalletCategory, rhs: WalletCategory) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}

public enum WalletCategoryError: Error {
    case invalidRawValue
}
