//
//  WalletCategory.swift
//  
//
//  Created by Dimas Gabriel on 7/4/24.
//

public enum WalletCategory: Int, CaseIterable {
    case spending = 0
    case savings = 1
    case debt = 2

    public var title: String {
        switch self {
        case .spending:
            "Spending Wallets"
        case .savings:
            "Savings Wallets"
        case .debt:
            "Debt Wallets"
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
