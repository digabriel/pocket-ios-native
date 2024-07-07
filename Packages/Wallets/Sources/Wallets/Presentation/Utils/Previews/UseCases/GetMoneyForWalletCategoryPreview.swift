//
//  GetMoneyForWalletCategoryPreview.swift
//  
//
//  Created by Dimas Gabriel on 7/6/24.
//

import CommonDomain

final class GetMoneyForWalletCategoryPreview: GetMoneyForWalletCategoryProtocol {
    private let money: Money

    init(money: Money = Money(amount: 200000)) {
        self.money = money
    }

    func execute(input: WalletCategory) async throws -> Money {
        return money
    }
}
