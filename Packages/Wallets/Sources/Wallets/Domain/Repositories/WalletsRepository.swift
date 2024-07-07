//
//  WalletsRepository.swift
//  
//
//  Created by Dimas Gabriel on 7/5/24.
//

protocol WalletsRepositoryProtocol {
    func getAllByCategory(_ category: WalletCategory) async throws -> [Wallet]
}

