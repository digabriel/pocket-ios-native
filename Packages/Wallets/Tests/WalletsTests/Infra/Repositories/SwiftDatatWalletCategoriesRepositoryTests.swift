//
//  SwiftDatatWalletCategoriesRepositoryTests.swift
//
//
//  Created by Dimas Gabriel on 7/5/24.
//

import Testing
import SwiftData
@testable import Wallets

struct SwiftDatatWalletCategoriesRepositoryTests {
    private let sut: SwiftDataWalletCategoriesRepository
    private let modelContainer: ModelContainer

    init() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        modelContainer = try ModelContainer(for: SwiftDataWalletCategory.self, configurations: config)
        sut = .init(modelContainer: modelContainer)
    }

    @Test func testGetAll() async throws {
        let categories: [SwiftDataWalletCategory] = [.init(identifier: 0), .init(identifier: 1), .init(identifier: 2)]
        let context = ModelContext(modelContainer)
        categories.forEach { context.insert($0) }
        try context.save()

        let fetchedCategories = try await sut.getAll()

        #expect(fetchedCategories.map { $0.rawValue } == categories.map { $0.identifier }.sorted())
    }

    @Test func shouldCreatwWithSuccess() async throws {
        let allCategoriesIdentifier = WalletCategory.allCases.map { $0.rawValue }
        let context = ModelContext(modelContainer)

        try await sut.create(category: .savings)
        let fetchAll = FetchDescriptor<SwiftDataWalletCategory>()
        let fetchedCategories = try context.fetch(fetchAll)

        #expect(fetchedCategories == [.init(domainModel: .savings)])
    }
}

