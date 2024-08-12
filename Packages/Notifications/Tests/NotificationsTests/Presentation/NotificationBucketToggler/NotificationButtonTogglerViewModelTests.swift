import Testing
import SwiftData
@testable import Notifications

typealias SUT = NotificationBucketTogglerList.ViewModel

struct NotificationButtonTogglerViewModelTests {
    private var context: ModelContext

    init() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: NotificationBucket.self, configurations: config)
        context = ModelContext(container)

        for key in NotificationBucket.Key.allCases {
            context.insert(NotificationBucket(key: key, isEnabled: false))
        }
    }

    private func makeSut(for keys: [NotificationBucket.Key]) -> SUT {
        return .init(
            modelContext: context,
            keys: keys
        )
    }

    @Test("Fetch only the requested buckets")
    func fetchOnlyRequestedBuckets() throws {
        let sut = makeSut(for: [.billReminders])
        #expect(sut.notificationBuckets.count == 1)
    }

    @Test("Fetch buckets in the correct order")
    func fetchInTheCorrectOrder() throws {
        let sut = makeSut(for: NotificationBucket.Key.allCases)
        let keys = sut.notificationBuckets.map { $0.key }

        #expect(keys == [0, 1])
    }

    @Test("Toggle isEnabled")
    func toggleIsEnabledShouldBePersisted() throws {
        let sut = makeSut(for: [.billReminders])
        let bucket = sut.notificationBuckets.first
        try #require(bucket != nil)

        #expect(bucket?.isEnabled == false)

        if let bucket {
            sut.toggle(bucket: bucket, isEnabled: true)
        }

        #expect(bucket?.isEnabled == true)
    }
}
