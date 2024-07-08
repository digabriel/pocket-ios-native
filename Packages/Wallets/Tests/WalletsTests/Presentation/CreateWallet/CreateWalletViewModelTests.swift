//
//  CreateWalletViewModelTests.swift
//  
//
//  Created by Dimas Gabriel on 7/7/24.
//

import Testing
@testable import Wallets

struct CreateWalletViewModelTests {
    private let walletCategoriesRepository = InMemoryWalletCategoriesRepository()
    
    private func makeSut() -> CreateWalletNavigationStack.ViewModel {
        let getWalletCategories = GetWalletCategoriesUseCase(repository: walletCategoriesRepository)
        let dependency = CreateWalletNavigationStack.Dependency(getWalletCategoriesUseCase: getWalletCategories)
        return CreateWalletNavigationStack.ViewModel(dependency: dependency)
    }

    @Test func shouldOutputWalletCategoriesAsSections() async throws {
        try await walletCategoriesRepository.create(category: .savings)
        try await walletCategoriesRepository.create(category: .debt)
        
        let sut = makeSut()
        await sut.refresh()

        #expect(sut.sections.count == 2)
        #expect(sut.sections[0].title == "Savings")
        #expect(sut.sections[1].title == "Debt")
    }
}
