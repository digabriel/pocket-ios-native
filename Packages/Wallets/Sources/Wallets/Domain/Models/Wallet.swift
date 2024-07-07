//
//  Wallet.swift
//  
//
//  Created by Dimas Gabriel on 7/4/24.
//

import Foundation
import CommonDomain

public struct Wallet {
    public let category: WalletCategory
    public let amount: Money

    init(category: WalletCategory, amount: Money) {
        self.category = category
        self.amount = amount
    }
}
