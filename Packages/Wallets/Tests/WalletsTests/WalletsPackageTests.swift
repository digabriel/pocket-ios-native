import Testing
import SwiftData
@testable import Wallets

struct WalletsPackageTests {
    @Test func setupDataInsertsWalletsCategories() async throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: SwiftDataWallet.self, configurations: config)
        let context = ModelContext(container)

        let sut = SwiftUIWalletsPackage(swiftDataContainer: container)
        await sut.setupData()

        let fetchAllCategories = FetchDescriptor<SwiftDataWalletCategory>()
        let allCategories = try context.fetch(fetchAllCategories).map { try $0.toDomain() }
        #expect(allCategories.sorted() == WalletCategory.allCases.sorted())
    }
}
