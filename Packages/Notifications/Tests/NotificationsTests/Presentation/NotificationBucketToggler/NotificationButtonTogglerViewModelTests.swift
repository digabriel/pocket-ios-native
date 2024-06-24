import Testing
import SwiftData
@testable import Notifications

typealias SUT = NotificationBucketTogglerList.ViewModel

struct NotificationButtonTogglerViewModelTests {
    @MainActor
    private func makeSut(for keys: [NotificationBucket.Key]) throws -> SUT {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: NotificationBucket.self, configurations: config)

        for key in NotificationBucket.Key.allCases {
            container.mainContext.insert(NotificationBucket(key: key, isEnabled: false))
        }

        try container.mainContext.save()

        return .init(
            modelContext: container.mainContext,
            keys: keys
        )
    }

    @MainActor @Test("Fetch only the requested buckets")
    func fetchOnlyRequestedBuckets() throws {
        let sut = try makeSut(for: [.billReminders])
        #expect(sut.notificationBuckets.count == 1)
    }

    @MainActor @Test("Fetch buckets in the correct order")
    func fetchInTheCorrectOrder() throws {
        let sut = try makeSut(for: [.billReminders, .dailyExpenses])
        let keys = sut.notificationBuckets.map { $0.key }
        #expect(keys == [0, 1])
    }
}

