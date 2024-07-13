//
//  WalletCategoriesRepositorySpy.swift
//  
//
//  Created by Dimas Gabriel on 7/5/24.
//

@testable import Wallets

@MainActor
final class WalletCategoriesRepositorySpy: WalletCategoriesRepositoryProtocol {
    private(set) var getAllCount = 0
    private(set) var createAllCount = 0

    func getAll() async throws -> [WalletCategory] {
        getAllCount += 1
        return []
    }

    func create(category: WalletCategory) async throws {
        createAllCount += 1
    }
}
