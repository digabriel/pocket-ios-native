//
//  SwiftDataWalletCategoriesRepository.swift
//  
//
//  Created by Dimas Gabriel on 7/6/24.
//

import SwiftData

@ModelActor
actor SwiftDataWalletCategoriesRepository: WalletCategoriesRepositoryProtocol {
    func getAll() async throws -> [WalletCategory] {
        let fetchCategories = FetchDescriptor<SwiftDataWalletCategory>()
        return try modelContext.fetch(fetchCategories)
            .map { try $0.toDomain() }
            .sorted()
    }

    func create(category: WalletCategory) async throws {
        modelContext.insert(SwiftDataWalletCategory(identifier: category.rawValue))
        try modelContext.save()
    }
}
