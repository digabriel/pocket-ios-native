//
//  InMemoryWalletsRepository.swift
//  
//
//  Created by Dimas Gabriel on 7/7/24.
//

@testable import Wallets

final class InMemoryWalletsRepository: WalletsRepositoryProtocol {
    private var wallets: [Wallet] = []

    func getAllByCategory(_ category: WalletCategory) async throws -> [Wallet] {
        return wallets.filter { $0.category == category }
    }

    func create(_ wallet: Wallet) async throws {
        wallets.append(wallet)
    }
}
