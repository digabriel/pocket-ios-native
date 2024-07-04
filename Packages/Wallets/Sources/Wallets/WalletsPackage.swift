//
//  WalletsPackage.swift
//  
//
//  Created by Dimas Gabriel on 7/4/24.
//

import CommonDomain
import SwiftData
import Logging

public final class WalletsPackage: PackageConfigurator {
    private let logger = Logger(label: "net.dimasgabriel.Pocket.Wallets")
    private let modelContext: ModelContext

    public init(modelContainer: ModelContainer) {
        modelContext = ModelContext(modelContainer)
        modelContext.autosaveEnabled = true
    }

    public func setupData() async {
        await buildWalletCategories()
    }

    private func buildWalletCategories() async {
        do {
            let descriptor = FetchDescriptor<WalletCategory>()
            let existingCategories = try modelContext.fetch(descriptor).map { $0.value }
            logger.info("Existing WalletCategories: \(existingCategories.count)")

            for walletCategory in WalletCategory.Value.allCases {
                if existingCategories.contains(walletCategory) == false {
                    modelContext.insert(WalletCategory(value: walletCategory))
                    logger.info("Inserted WalletCategory: \(walletCategory)")
                }
            }

            try? modelContext.save()
        } catch {
            logger.error("Error populating WalletCategories: \(error.localizedDescription)")
        }
    }
}
