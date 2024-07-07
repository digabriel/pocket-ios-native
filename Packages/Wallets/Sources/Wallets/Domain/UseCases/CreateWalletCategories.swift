//
//  CreateWalletCategories.swift
//  
//
//  Created by Dimas Gabriel on 7/6/24.
//

import CommonDomain

public protocol CreateWalletCategoriesProtocol: UseCase where Input == Void, Output == Void {}

public final class CreateWalletCategoriesUseCase: CreateWalletCategoriesProtocol {
    private let repository: WalletCategoriesRepositoryProtocol

    init(repository: WalletCategoriesRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(input: ()) async throws -> () {
        let allCategories = Set(WalletCategory.allCases)
        let existingCategories = Set(try await repository.getAll())

        for category in allCategories.subtracting(existingCategories) {
            try await repository.create(category: category)
        }
    }
}
