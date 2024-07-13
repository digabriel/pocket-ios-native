//
//  WalletsCategoriesRepositorymock.swift
//  
//
//  Created by Dimas Gabriel on 7/6/24.
//

@testable import Wallets

@MainActor
final class InMemoryWalletCategoriesRepository: WalletCategoriesRepositoryProtocol {
    private var categories: [WalletCategory] = []

    func getAll() async throws -> [WalletCategory] {
        return categories
    }

    func create(category: WalletCategory) async throws {
        categories.append(category)
    }
}
