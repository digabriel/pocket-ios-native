//
//  CreateWalletModel+Mock.swift
//  Wallets
//
//  Created by Dimas Gabriel on 8/9/24.
//

@testable import Wallets
import CommonDomain
import SwiftUI

extension CreateWalletModel {
    static func mock(
        name: String = "Test",
        category: WalletCategory = .spending,
        initialBalance: Money = .zero(currency: .BRL),
        iconName: String = "Car",
        iconBackgroundColor: Color = .red
    ) -> Self {
        .init(
            name: name,
            category: category,
            initialBalance: initialBalance,
            iconName: iconName,
            iconBackgroundColor: iconBackgroundColor
        )
    }
}
