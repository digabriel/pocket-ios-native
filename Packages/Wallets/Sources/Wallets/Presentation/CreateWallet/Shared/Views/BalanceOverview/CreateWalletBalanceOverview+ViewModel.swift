//
//  CreateWalletBalanceOverview+ViewModel.swift
//  Wallets
//
//  Created by Dimas Gabriel on 8/20/24.
//

import Foundation
import CommonDomain

extension CreateWalletBalanceOverviewView {
    @MainActor @Observable final class ViewModel {
        private(set) var balanceType: BalanceType

        let title: String
        var fields: [ValueField]

        init(balanceType: BalanceType) {
            self.balanceType = balanceType
            self.title = balanceType.title
            self.fields = balanceType.fields
        }
    }
}

extension CreateWalletBalanceOverviewView {
    struct ValueField: Identifiable {
        var id: String { title }
        let title: String
        let currency: Currency
        var formattedValue: String
        var showsDisclosureIndicator: Bool
        let initialValue: Decimal
        var currentValue: Decimal {
            didSet {
                formattedValue = Money(amount: currentValue, currency: currency).formatted()
                showsDisclosureIndicator = showsDisclosureIndicator && initialValue == currentValue
            }
        }
    }

    enum BalanceType {
        case spending(currentBalance: Money, goalBalance: Money?)
        case saving(currentBalance: Money, goalBalance: Money?)
        case debt(startingDebt: Money, leftToPay: Money)

        fileprivate var title: String {
            switch self {
            case .spending:
                return WalletCategory.spending.name
            case .saving:
                return WalletCategory.savings.name
            case .debt:
                return WalletCategory.debt.name
            }
        }

        fileprivate var fields: [ValueField] {
            switch self {
            case .spending(let currentBalance, let goalBalance), .saving(let currentBalance, let goalBalance):
                return [
                    .init(
                        title: String(localized: "Current balance"),
                        currency: currentBalance.currency,
                        formattedValue: currentBalance.formatted(),
                        showsDisclosureIndicator: false,
                        initialValue: currentBalance.amount,
                        currentValue: currentBalance.amount
                    ),
                    .init(
                        title: String(localized: "Goal amount"),
                        currency: goalBalance?.currency ?? currentBalance.currency,
                        formattedValue: goalBalance?.formatted() ?? "",
                        showsDisclosureIndicator: goalBalance == nil || goalBalance?.amount == 0,
                        initialValue: goalBalance?.amount ?? 0,
                        currentValue: goalBalance?.amount ?? 0
                    )
                ]
            case .debt(let startingDebt, let leftToPay):
                return [
                    .init(
                        title: String(localized: "Left to pay"),
                        currency: leftToPay.currency,
                        formattedValue: leftToPay.formatted(),
                        showsDisclosureIndicator: false,
                        initialValue: leftToPay.amount,
                        currentValue: leftToPay.amount
                    ),
                    .init(
                        title: String(localized: "Starting debt"),
                        currency: startingDebt.currency,
                        formattedValue: startingDebt.formatted(),
                        showsDisclosureIndicator: false,
                        initialValue: startingDebt.amount,
                        currentValue: startingDebt.amount
                    )
                ]
            }
        }
    }
}
