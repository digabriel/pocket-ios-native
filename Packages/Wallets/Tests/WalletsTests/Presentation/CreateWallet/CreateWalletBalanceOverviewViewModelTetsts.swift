//
//  CreateWalletBalanceOveriviewViewModelTetsts.swift
//  Wallets
//
//  Created by Dimas Gabriel on 8/20/24.
//

import Testing
@testable import Wallets

@MainActor
struct CreateWalletBalanceOverviewViewModelTetsts {
    func makeSut(
        balanceType: CreateWalletBalanceOverviewView.BalanceType
    ) -> CreateWalletBalanceOverviewView.ViewModel {
        .init(balanceType: balanceType)
    }

    @Test(arguments: [
        CreateWalletBalanceOverviewView.BalanceType.saving(currentBalance: .zero(currency: .USD), goalBalance: nil),
        .spending(currentBalance: .zero(currency: .USD), goalBalance: nil),
        .debt(startingDebt: .zero(currency: .USD), leftToPay: .zero(currency: .USD))
    ])
    func titleMapsToWalletCategoryName(balanceType: CreateWalletBalanceOverviewView.BalanceType) {
        let sut = makeSut(balanceType: balanceType)
        let title = sut.title

        switch balanceType {
        case .spending:
            #expect(title == WalletCategory.spending.name)
        case .saving:
            #expect(title == WalletCategory.savings.name)
        case .debt:
            #expect(title == WalletCategory.debt.name)
        }
    }
}
