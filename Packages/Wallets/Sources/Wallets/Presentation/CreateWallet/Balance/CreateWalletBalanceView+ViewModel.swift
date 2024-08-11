//
//  CreateWalletBalanceView+ViewModel.swift
//  Wallets
//
//  Created by Dimas Gabriel on 8/9/24.
//

import Foundation
import CommonDomain

extension CreateWalletBalanceView {
    @MainActor @Observable final class ViewModel {
        let title: String
        let inputPlaceholderText: String
        var inputValue: Decimal
        var currency: Currency { model.initialBalance.currency }

        private var model: CreateWalletModel

        init(model: CreateWalletModel) {
            self.model = model
            self.title = model.name
            self.inputPlaceholderText = model.category.inputPlaceholderText
            self.inputValue = model.initialBalance.amount
        }
    }
}

private extension WalletCategory {
    var inputPlaceholderText: String {
        switch self {
        case .spending:
            String(localized: "Current balance")
        case .savings:
            String(localized: "Current balance")
        case .debt:
            String(localized: "How much was the debt from the start?")
        }
    }
}

extension CreateWalletModel {
    func updatingInitialBalance(newAmount: Decimal) -> CreateWalletModel {
        let money = Money(amount: newAmount, currency: self.initialBalance.currency)
        return .init(name: self.name, category: self.category, initialBalance: money)
    }
}
