//
//  CreateWalletModelV2+Preview.swift
//  Wallets
//
//  Created by Dimas Gabriel on 8/22/24.
//

import SwiftUI
import Styleguide

extension CreateWalletModel {
    static func preview() -> CreateWalletModel {
        let model = CreateWalletModel()
        model.name = "Wallet"
        model.iconBackgroundColor = Color.regular.red
        model.iconName = "car"
        return model
    }
}
