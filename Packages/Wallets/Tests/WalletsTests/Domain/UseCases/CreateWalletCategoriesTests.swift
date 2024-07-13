//
//  CreateWalletCategoriesTests.swift
//  
//
//  Created by Dimas Gabriel on 7/6/24.
//

import Testing
@testable import Wallets

@MainActor
struct CreateWalletCategoriesTests {
    @Test func shouldCallRepositoryForEachCategory() async throws {
        let repository = WalletCategoriesRepositorySpy()
        let sut = CreateWalletCategoriesUseCase(repository: repository)

        _ = try await sut.execute(input: ())

        #expect(repository.createAllCount == WalletCategory.allCases.count)
    }

    @Test func shouldNotDuplicateCategories() async throws {
        let repository = InMemoryWalletCategoriesRepository()
        try await repository.create(category: .savings)

        let sut = CreateWalletCategoriesUseCase(repository: repository)
        _ = try await sut.execute(input: ())

        let allCategories = try await repository.getAll()
        #expect(allCategories.map { $0.rawValue }.sorted() == WalletCategory.allCases.map { $0.rawValue }.sorted())
    }
}
