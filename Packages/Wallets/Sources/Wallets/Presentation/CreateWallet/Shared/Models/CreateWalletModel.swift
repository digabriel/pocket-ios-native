//
//  CreateWalletModel.swift
//  Wallets
//
//  Created by Dimas Gabriel on 8/9/24.
//

import Foundation
import CommonDomain
import SwiftUI

struct CreateWalletModel: Equatable, Hashable {
    let name: String
    let category: WalletCategory
    let initialBalance: Money
    let iconName: String
    let iconBackgroundColor: Color
    let settings: [Setting]
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

        static var allSettings: [Self] {
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
