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
    public private(set) var category: SwiftDataWalletCategory
    public private(set) var amount: Decimal
    public private(set) var currencyCode: String

    init(category: SwiftDataWalletCategory, amount: Decimal, currencyCode: String) {
        self.category = category
        self.amount = amount
        self.currencyCode = currencyCode
    }
}

extension SwiftDataWallet {
    func toDomain() throws -> Wallet {
        guard let walletCategory = WalletCategory(rawValue: category.identifier) else {
            throw WalletCategoryError.invalidRawValue
        }

        let currency = try Currency.from(code: currencyCode)

        return .init(category: walletCategory, amount: Money(amount: amount, currency: currency))
    }

    convenience init(domainModel: Wallet) {
        self.init(
            category: .init(identifier: domainModel.category.rawValue),
            amount: domainModel.amount.amount,
            currencyCode: domainModel.amount.currency.code
        )
    }
}
