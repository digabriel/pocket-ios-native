//
//  NotificationBucketToggler+ViewModel.swift
//  
//
//  Created by Dimas Gabriel on 6/21/24.
//

import SwiftData
import Foundation

internal extension NotificationBucketTogglerList {
    final class ViewModel {
        private let modelContext: ModelContext
        var notificationBuckets = [NotificationBucket]()

        init(modelContext: ModelContext, keys: [NotificationBucket.Key]) {
            self.modelContext = modelContext
            fetchBucket(for: keys)
        }

        private func fetchBucket(for keys: [NotificationBucket.Key]) {
            let keys = keys.map { $0.rawValue }
            do {
                let descriptor = FetchDescriptor<NotificationBucket>(
                    predicate: #Predicate { keys.contains($0.key) },
                    sortBy: [SortDescriptor<NotificationBucket>(\.key)]
                )

                notificationBuckets = try modelContext.fetch(descriptor)
            } catch {
                notificationBuckets = []
            }
        }

        func toggle(bucket: NotificationBucket, isEnabled: Bool) {
            bucket.isEnabled = isEnabled
        }
    }
}
