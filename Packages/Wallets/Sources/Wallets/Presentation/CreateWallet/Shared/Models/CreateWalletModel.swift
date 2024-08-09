//
//  CreateWalletModel.swift
//  Wallets
//
//  Created by Dimas Gabriel on 8/9/24.
//

import Foundation
import CommonDomain

struct CreateWalletModel: Equatable, Hashable {
    let name: String
    let category: WalletCategory
    let initialBalance: Money
}
