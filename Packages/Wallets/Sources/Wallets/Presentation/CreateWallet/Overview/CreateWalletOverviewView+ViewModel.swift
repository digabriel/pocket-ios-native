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
        let balanceViewModel: CreateWalletBalanceOverviewView.ViewModel

        init(model: CreateWalletModel) {
            nameViewModel = .init(model: model)

            let balanceType: CreateWalletBalanceOverviewView.BalanceType = switch model.category {
            case .spending:
               .spending(currentBalance: model.initialBalance, goalBalance: nil)
            case .savings:
                .saving(currentBalance: model.initialBalance, goalBalance: nil)
            case .debt:
                .debt(startingDebt: model.initialBalance, leftToPay: model.initialBalance)
            }
            balanceViewModel = .init(balanceType: balanceType)
        }
    }
}
