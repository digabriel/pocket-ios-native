//
//  CreateWalletModel.swift
//  Wallets
//
//  Created by Dimas Gabriel on 8/21/24.
//

import Foundation
import Styleguide
import SwiftUI
import CommonDomain

@Observable final class CreateWalletModel {
    var walletCategory: WalletCategory = .spending
    var currency: Currency = .USD
    var name: String = ""
    var iconName: String = ""
    var iconBackgroundColor: Color = Color.black.opacity(0)
    var initialBalanceAmount: Decimal = .zero
    var goalBalanceAmount: Decimal = .zero {
        didSet {
            hasGoalBalanceAmount = goalBalanceAmount > .zero
        }
    }
    var hasGoalBalanceAmount: Bool = false
    var leftToPayBalanceAmount: Decimal = .zero
    var settings: [Setting] = CreateWalletModel.Setting.allSettings

    func reset() {
        walletCategory = .spending
        currency = .USD
        name = ""
        iconName = ""
        iconBackgroundColor = Color.black.opacity(0)
        initialBalanceAmount = .zero
        goalBalanceAmount = .zero
        hasGoalBalanceAmount = false
        leftToPayBalanceAmount = .zero
        settings = CreateWalletModel.Setting.allSettings
    }
}

extension CreateWalletModel {
    enum SettingIdentifier {
        case netWorth, defaultWallet
    }

    struct Setting: Equatable, Hashable {
        let identifier: SettingIdentifier
        let title: String
        let description: String?
        var isEnabled: Bool

        fileprivate static var allSettings: [Self] {
            return [
                .init(
                    identifier: .netWorth,
                    title: String(localized: "Include in net worth"),
                    description: nil,
                    isEnabled: false
                ),
                .init(
                    identifier: .defaultWallet,
                    title: String(localized: "Default wallet"),
                    description: String(localized: "Make this wallet pre-selected when creating transactions"),
                    isEnabled: false
                )
            ]
        }
    }
}
