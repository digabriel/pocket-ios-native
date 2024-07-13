//
//  WalletMainView+ViewModel.swift
//  
//
//  Created by Dimas Gabriel on 7/1/24.
//

import Foundation

extension WalletsMainView {
    @MainActor @Observable final class ViewModel {
        let childrenViewModels: Children

        init(dependency: Dependency) {
            let walletsSummaryDependency = WalletsSummaryView.Dependency(
                getWalletCategoriesUseCase: dependency.getWalletCategoriesUseCase,
                getMoneyForWalletCategoryUseCase: dependency.getMoneyForWalletCategoryUseCase
            )
            let createWalletDependency = CreateWalletNavigationStack.Dependency(
                getWalletCategoriesUseCase: dependency.getWalletCategoriesUseCase
            )

            let walletsSummaryViewModel = WalletsSummaryView.ViewModel(dependency: walletsSummaryDependency)
            let createWalletViewModel = CreateWalletNavigationStack.ViewModel(dependency: createWalletDependency)

            self.childrenViewModels = .init(
                walletsSummary: walletsSummaryViewModel,
                createWallet: createWalletViewModel
            )
        }
    }
}

public extension WalletsMainView {
    struct Dependency {
        let getWalletCategoriesUseCase: any GetWalletCategoriesProtocol
        let getMoneyForWalletCategoryUseCase: any GetMoneyForWalletCategoryProtocol

        public init(
            getWalletCategoriesUseCase: any GetWalletCategoriesProtocol,
            getMoneyForWalletCategoryUseCase: any GetMoneyForWalletCategoryProtocol
        ) {
            self.getWalletCategoriesUseCase = getWalletCategoriesUseCase
            self.getMoneyForWalletCategoryUseCase = getMoneyForWalletCategoryUseCase
        }
    }
}

extension WalletsMainView.ViewModel {
    struct Children {
        let walletsSummary: WalletsSummaryView.ViewModel
        let createWallet: CreateWalletNavigationStack.ViewModel
    }
}
