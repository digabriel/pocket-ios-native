//
//  CreateWalletOverviewView+ViewModel.swift
//  Wallets
//
//  Created by Dimas Gabriel on 8/12/24.
//

import Foundation

extension CreateWalletOverviewView {
    @MainActor @Observable final class ViewModel {
        let nameViewModel: CreateWalletNameView.ViewModel

        init(model: CreateWalletModel) {
            nameViewModel = .init(model: model)
        }
    }
}
