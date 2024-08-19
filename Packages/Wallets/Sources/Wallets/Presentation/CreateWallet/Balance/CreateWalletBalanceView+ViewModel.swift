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
        let descriptionText: String
        let currency: Currency
        var inputValue: Decimal

        private let model: CreateWalletModel

        var updatedModel: CreateWalletModel {
            model.updatingInitialBalance(newAmount: inputValue)
        }

        init(model: CreateWalletModel) {
            self.model = model
            self.title = model.name
            self.inputPlaceholderText = model.category.inputPlaceholderText
            self.descriptionText = model.category.descriptionText
            self.currency = model.initialBalance.currency
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

    var descriptionText: String {
        switch self {
        case .spending:
            String(localized: "You can estimate now and change it whenever you want")
        case .savings:
            String(localized: "You can estimate now and change it whenever you want")
        case .debt:
            String(localized: "Provide the amount of debt when you acquired it.")
        }
    }
}

private extension CreateWalletModel {
    func updatingInitialBalance(newAmount: Decimal) -> CreateWalletModel {
        let money = Money(amount: newAmount, currency: self.initialBalance.currency)
        return .init(
            name: self.name,
            category: self.category,
            initialBalance: money,
            iconName: iconName,
            iconBackgroundColor: iconBackgroundColor
        )
    }
}
