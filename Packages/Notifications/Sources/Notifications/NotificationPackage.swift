//
//  NotificationPackage.swift
//  
//
//  Created by Dimas Gabriel on 6/25/24.
//

import Foundation
import SwiftData
import Logging
import CommonDomain

public struct NotificationPackage: PackageConfigurator, Sendable {
    private let logger = Logger(label: "net.dimasgabriel.Pocket.Notifications")
    private let modelContext: ModelContext

    public init(modelContainer: ModelContainer) {
        modelContext = ModelContext(modelContainer)
        modelContext.autosaveEnabled = true
    }
    
    public func setupData() async {
        await buildNotificationsBucket()
    }

    private func buildNotificationsBucket() async {
        do {
            let descriptor = FetchDescriptor<NotificationBucket>()
            let existingBuckets = try modelContext.fetch(descriptor).map { $0.key }
            logger.info("Existing NotificationBuckets: \(existingBuckets.count)")

            for notificationBucketKey in NotificationBucket.Key.allCases {
                if existingBuckets.contains(notificationBucketKey.rawValue) == false {
                    modelContext.insert(NotificationBucket(key: notificationBucketKey, isEnabled: true))
                    logger.info("Inserted NotificationBucket: \(notificationBucketKey)")
                }
            }
        } catch {
            logger.error("Error populating NotificationBuckets: \(error.localizedDescription)")
        }
    }
}
