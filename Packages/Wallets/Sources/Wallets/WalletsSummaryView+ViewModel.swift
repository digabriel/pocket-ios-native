//
//  WalletsSummaryViewModel.swift
//  
//
//  Created by Dimas Gabriel on 7/4/24.
//

import Foundation
import CommonDomain

extension WalletsSummaryView {
    @MainActor @Observable final class ViewModel {
        private(set) var items: [Model] = []
        private let dependency: Dependency

        init(dependency: Dependency) {
            self.dependency = dependency
        }

        func refresh() async {
            do {
                var items: [Model] = []
                let walletCategories = try await dependency.getWalletCategoriesUseCase.execute(input: ())

                for category in walletCategories {
                    let categoryAmount = try await dependency.getMoneyForWalletCategoryUseCase.execute(input: category)
                    items.append(.init(amount: categoryAmount, title: category.name, category: category))
                }

                self.items = items
            } catch {
                items = []
            }
        }
    }
}

extension WalletsSummaryView {
    struct Model: Identifiable, Equatable {
        let amount: Money
        let title: String
        let category: WalletCategory

        var id: Int { category.rawValue }
    }

    struct Dependency {
        let getWalletCategoriesUseCase: any GetWalletCategoriesProtocol
        let getMoneyForWalletCategoryUseCase: any GetMoneyForWalletCategoryProtocol

        init(
            getWalletCategoriesUseCase: any GetWalletCategoriesProtocol,
            getMoneyForWalletCategoryUseCase: any GetMoneyForWalletCategoryProtocol
        ) {
            self.getWalletCategoriesUseCase = getWalletCategoriesUseCase
            self.getMoneyForWalletCategoryUseCase = getMoneyForWalletCategoryUseCase
        }
    }
}
