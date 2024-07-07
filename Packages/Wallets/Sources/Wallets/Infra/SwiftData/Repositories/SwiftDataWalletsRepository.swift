//
//  SwiftDataWalletsRepository.swift
//  
//
//  Created by Dimas Gabriel on 7/6/24.
//

import Foundation
import SwiftData

@ModelActor
actor SwiftDataWalletsRepository: WalletsRepositoryProtocol {
    func getAllByCategory(_ category: WalletCategory) async throws -> [Wallet] {
        let fetchDescriptor = FetchDescriptor<SwiftDataWallet>()
        
        return try modelContext.fetch(fetchDescriptor)
            .filter { $0.category.identifier == category.rawValue } // TODO: Filtering in memory because #Predicate don't work with enums.
            .map { try $0.toDomain() }
    }
}
