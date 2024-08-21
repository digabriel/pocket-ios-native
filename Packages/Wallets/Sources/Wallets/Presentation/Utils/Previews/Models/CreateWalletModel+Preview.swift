//
//  CreateWalletModel+Preview.swift
//  Wallets
//
//  Created by Dimas Gabriel on 8/9/24.
//

import CommonDomain
import SwiftUI

extension CreateWalletModel {
    static func preview(
        name: String = "Test",
        category: WalletCategory = .spending,
        initialBalance: Money = .zero(currency: .BRL),
        iconName: String = "car",
        iconBackgroundColor: Color = .regular.purple,
        settings: [CreateWalletModel.Setting] = CreateWalletModel.Setting.allSettings
    ) -> Self {
        .init(
            name: name,
            category: category,
            initialBalance: initialBalance,
            iconName: iconName,
            iconBackgroundColor: iconBackgroundColor,
            settings: settings
        )
    }
}
