//
//  GetWalletCategoriesTests.swift
//  
//
//  Created by Dimas Gabriel on 7/5/24.
//

import Testing
@testable import Wallets

@MainActor
struct GetWalletCategoriesTests {
    @Test func callsRepository() async throws {
        let repository = WalletCategoriesRepositorySpy()
        let sut = GetWalletCategoriesUseCase(repository: repository)
        
        _ = try await sut.execute(input: ())

        #expect(await repository.getAllCount == 1)
    }
}
