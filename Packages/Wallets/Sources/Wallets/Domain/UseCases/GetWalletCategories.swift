//
//  GetWalletCategories.swift
//  
//
//  Created by Dimas Gabriel on 7/5/24.
//

import CommonDomain

public protocol GetWalletCategoriesProtocol: UseCase where Input == Void, Output == [WalletCategory] {}

public final class GetWalletCategoriesUseCase: GetWalletCategoriesProtocol {
    let repository: WalletCategoriesRepositoryProtocol

    init(repository: WalletCategoriesRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(input: Void) async throws -> [WalletCategory] {
        return try await self.repository
            .getAll()
            .sorted()
    }
}
