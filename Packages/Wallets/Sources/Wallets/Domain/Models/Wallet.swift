//
//  Wallet.swift
//  
//
//  Created by Dimas Gabriel on 7/4/24.
//

import Foundation
import CommonDomain

public struct Wallet: Sendable {
    public let category: WalletCategory
    public let amount: Money
}
