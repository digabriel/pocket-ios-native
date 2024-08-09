//
//  CreateWalletModel+Preview.swift
//  Wallets
//
//  Created by Dimas Gabriel on 8/9/24.
//

import CommonDomain

extension CreateWalletModel {
    static func preview(
        name: String = "Test",
        category: WalletCategory = .spending,
        initialBalance: Money = .zero(currency: .BRL)
    ) -> Self {
        .init(name: name, category: category, initialBalance: initialBalance)
    }
}
