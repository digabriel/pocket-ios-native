//
//  WalletsRepository.swift
//  
//
//  Created by Dimas Gabriel on 7/5/24.
//

protocol WalletsRepositoryProtocol: Sendable {
    func getAllByCategory(_ category: WalletCategory) async throws -> [Wallet]
}
