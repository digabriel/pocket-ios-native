//
//  GetAmountForWalletCategoryTests.swift
//  
//
//  Created by Dimas Gabriel on 7/5/24.
//

@testable import Wallets
import Testing
import CommonDomain

@MainActor
struct GetAmountForWalletCategoryTests {
    private let sut: GetMoneyForWalletCategoryUseCase
    private let repository: WalletsRepositoryMock

    init() {
        repository = WalletsRepositoryMock()
        sut = .init(repository: repository)
    }

    @Test @MainActor func amountIsSummedCorrectly() async throws {
        let category = WalletCategory.debt
        let wallets: [Wallet] = [
            .mock(category: category, amount: Money(amount: 100, currency: .USD)),
            .mock(category: category, amount: Money(amount: 50, currency: .USD)),
            .mock(category: WalletCategory.savings, amount: Money(amount: 100, currency: .USD))
        ]
        repository.getAllByCategoryResult = wallets

        let amount = try await sut.execute(input: category)

        #expect(amount == Money(amount: 150, currency: .USD))
    }
}
