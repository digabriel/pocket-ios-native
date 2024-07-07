//
//  SwiftDataWallet.swift
//  
//
//  Created by Dimas Gabriel on 7/6/24.
//

import SwiftData
import Foundation
import CommonDomain

@Model public final class SwiftDataWallet {
    public let category: SwiftDataWalletCategory
    public let amount: Decimal

    init(category: SwiftDataWalletCategory, amount: Decimal) {
        self.category = category
        self.amount = amount
    }
}

extension SwiftDataWallet {
    func toDomain() throws -> Wallet {
        guard let walletCategory = WalletCategory(rawValue: category.identifier) else {
            throw WalletCategoryError.invalidRawValue
        }

        return .init(category: walletCategory, amount: Money(amount: amount))
    }

    convenience init(domainModel: Wallet) {
        self.init(
            category: .init(identifier: domainModel.category.rawValue),
            amount: domainModel.amount.amount
        )
    }
}
