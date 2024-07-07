//
//  WalletsSummaryViewModelTests.swift
//  
//
//  Created by Dimas Gabriel on 7/7/24.
//

@testable import Wallets
import Testing
import CommonDomain

struct WalletsSummaryViewModelTests {
    private let walletCategoriesRepository = InMemoryWalletCategoriesRepository()
    private let walletsRepository = InMemoryWalletsRepository()

    private func makeSut() -> WalletsSummaryView.ViewModel {
        let getWalletCategories = GetWalletCategoriesUseCase(repository: walletCategoriesRepository)
        let getAmountForWalletCategory = GetMoneyForWalletCategoryUseCase(repository: walletsRepository)

        let dependency = WalletsSummaryView.Dependency(
            getWalletCategoriesUseCase: getWalletCategories,
            getMoneyForWalletCategoryUseCase: getAmountForWalletCategory
        )

        return .init(dependency: dependency)
    }

    @Test func shouldBuildItemsOutput() async throws {
        try await walletCategoriesRepository.create(category: .debt)
        try await walletCategoriesRepository.create(category: .savings)
        try await walletsRepository.create(.mock(category: .debt, amount: Money(amount: 100)))
        try await walletsRepository.create(.mock(category: .debt, amount: Money(amount: 200)))
        try await walletsRepository.create(.mock(category: .savings, amount: Money(amount: 50)))

        let sut = makeSut()
        await sut.refresh()

        let firstItem = sut.items[0]
        let secondItem = sut.items[1]
        #expect(sut.items.count == 2)
        #expect(firstItem.category == .savings)
        #expect(secondItem.category == .debt)
        #expect(firstItem.amount == Money(amount: 50))
        #expect(secondItem.amount == Money(amount: 300))

    }
}
