//
//  GetMoneyForWalletCategory.swift
//  
//
//  Created by Dimas Gabriel on 7/5/24.
//

import CommonDomain
import Foundation

public protocol GetMoneyForWalletCategoryProtocol: UseCase where Input == WalletCategory, Output == Money {}

public final class GetMoneyForWalletCategoryUseCase: GetMoneyForWalletCategoryProtocol {
    private let repository: WalletsRepositoryProtocol

    init(repository: WalletsRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(input: Input) async throws -> Output {
        let wallets = try await repository.getAllByCategory(input)
        return wallets.reduce(Money.zero, { $0 + $1.amount })
    }
}
