//
//  CreateWalletBalanceView+ViewModel.swift
//  Wallets
//
//  Created by Dimas Gabriel on 8/9/24.
//

import Foundation

extension CreateWalletBalanceView {
    @MainActor @Observable final class ViewModel {
        let title: String

        init(model: CreateWalletModel) {
            self.title = model.name
        }
    }
}
