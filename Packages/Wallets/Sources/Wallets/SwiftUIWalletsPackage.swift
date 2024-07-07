//
//  WalletsPackage.swift
//  
//
//  Created by Dimas Gabriel on 7/4/24.
//

import CommonDomain
import SwiftData
import Logging
import SwiftUI

@Observable public final class SwiftUIWalletsPackage: PackageConfigurator, Sendable {
    private let logger = Logger(label: "net.dimasgabriel.Pocket.Wallets")
    private let swiftDataRepositories: SwiftDataRepositories

    public let useCases: UseCases

    public init(swiftDataContainer: ModelContainer) {
        let repositories = SwiftDataRepositories(
            walletCategoriesRepository: .init(modelContainer: swiftDataContainer),
            walletsRepository: .init(modelContainer: swiftDataContainer)
        )

        self.swiftDataRepositories = repositories
        self.useCases = .init(repositories: repositories)
    }

    @MainActor
    public func setupData() async {
        await buildWalletCategories()
    }

    private func buildWalletCategories() async {
        do {
            let repository = swiftDataRepositories.walletCategoriesRepository
            let createWalletCategories = CreateWalletCategoriesUseCase(repository: repository)
            try await createWalletCategories.execute(input: ())
            logger.info("Created missing wallet categories")
        } catch {
            logger.error("Error creating wallet categories: \(error.localizedDescription)")
        }
    }
}

fileprivate extension SwiftUIWalletsPackage {
    struct SwiftDataRepositories {
        let walletCategoriesRepository: SwiftDataWalletCategoriesRepository
        let walletsRepository: SwiftDataWalletsRepository
    }
}

public extension SwiftUIWalletsPackage {
    struct UseCases: Sendable {
        private let repositories: SwiftDataRepositories

        public var getWalletCategoriesUseCase: GetWalletCategoriesUseCase {
            .init(repository: repositories.walletCategoriesRepository)
        }

        public var getMoneyForWalletCategoryUseCase: GetMoneyForWalletCategoryUseCase {
            .init(repository: repositories.walletsRepository)
        }

        fileprivate init(repositories: SwiftDataRepositories) {
            self.repositories = repositories
        }
    }
}
