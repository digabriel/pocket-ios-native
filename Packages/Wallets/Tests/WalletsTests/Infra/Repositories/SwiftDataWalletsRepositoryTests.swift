//
//  Untitled.swift
//  
//
//  Created by Dimas Gabriel on 7/5/24.
//

import Testing
import SwiftData
@testable import Wallets

struct SwiftDataWalletsRepositoryTests {
    private let sut: SwiftDataWalletsRepository
    private let modelContainer: ModelContainer

    init() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        modelContainer = try ModelContainer(for: SwiftDataWallet.self, configurations: config)
        sut = .init(modelContainer: modelContainer)
    }

    @Test func testGetAllByCategory() async throws {
        let context = ModelContext(modelContainer)
        let category = SwiftDataWalletCategory(identifier: 0)
        let wallets: [SwiftDataWallet] = [
            try .mock(category: category, insertedIn: context),
            try .mock(category: category, insertedIn: context)
        ]

        let fetchedWallets = try await sut.getAllByCategory(category.toDomain())

        #expect(fetchedWallets.count == 2)
    }
}
