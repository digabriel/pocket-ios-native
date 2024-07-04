import Testing
import SwiftData
@testable import Wallets

struct WalletsPackageTests {
    private let modelContainer: ModelContainer

    init() throws {
        let modelConfiguration = ModelConfiguration(for: WalletCategory.self, isStoredInMemoryOnly: true)
        self.modelContainer = try ModelContainer(for: WalletCategory.self, configurations: modelConfiguration)
    }

    private var modelContext: ModelContext {
        return ModelContext(modelContainer)
    }

    @Test func setupDataInsertsWalletsCategories() async throws {
        let sut = WalletsPackage.init(modelContainer: modelContainer)
        await sut.setupData()
        
        let descriptor = FetchDescriptor<WalletCategory>()
        let insertedCategories = try modelContext.fetch(descriptor).map { $0.value }
        #expect(Set(insertedCategories) == Set(WalletCategory.Value.allCases))
    }
}


