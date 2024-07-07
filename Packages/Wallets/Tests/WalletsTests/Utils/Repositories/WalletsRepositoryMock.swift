//
//  WalletsRepositoryMock.swift
//  
//
//  Created by Dimas Gabriel on 7/5/24.
//

@testable import Wallets

final class WalletsRepositoryMock: WalletsRepositoryProtocol {
    var getAllByCategoryResult: [Wallet]?

    func getAllByCategory(_ category: WalletCategory) async throws -> [Wallet] {
        return getAllByCategoryResult?.filter { $0.category == category } ?? []
    }
}
