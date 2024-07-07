import Testing
import SwiftData
@testable import Wallets

struct WalletsPackageTests {
    @Test func setupDataInsertsWalletsCategories() async throws {
        let repository = InMemoryWalletCategoriesRepository()
        let useCase = CreateWalletCategoriesUseCase(repository: repository)

        let sut = WalletsPackage.init(createWalletCategories: useCase)
        await sut.setupData()
        
        let allCategories = try await repository.getAll()
        #expect(allCategories.sorted() == WalletCategory.allCases.sorted())
    }
}


