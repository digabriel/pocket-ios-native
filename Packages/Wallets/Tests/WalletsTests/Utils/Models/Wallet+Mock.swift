//
//  Wallet+Mock.swift
//  
//
//  Created by Dimas Gabriel on 7/5/24.
//

@testable import Wallets
import Foundation
import SwiftData
import CommonDomain

extension Wallet {
    static func mock(category: WalletCategory, amount: Money = .zero) -> Wallet {
        return self.init(category: category, amount: amount)
    }
}

extension SwiftDataWallet {
    static func mock(category: SwiftDataWalletCategory, amount: Decimal = 0) -> SwiftDataWallet {
        .init(category: category, amount: amount)
    }

    static func mock(category: SwiftDataWalletCategory, amount: Decimal = 0, insertedIn context: ModelContext) throws -> SwiftDataWallet {
        let wallet = self.mock(category: category, amount: amount)
        context.insert(wallet)
        try context.save()
        return wallet
    }
}
