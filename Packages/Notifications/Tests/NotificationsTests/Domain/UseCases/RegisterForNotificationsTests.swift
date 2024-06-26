//
//  RegisterForNotificationsTests.swift
//  
//
//  Created by Dimas Gabriel on 6/26/24.
//

import Testing
@testable import Notifications

struct RegisterForNotificationsTests {
    @Test func shouldRegisterForNotificationsWithSuccess() async {
        let repository = RepositoryMock(currentStatus: .notDetermined, registrationResult: true)
        let sut = RegisterForNotifications(repository: repository)

        let result = await sut.execute(input: ())
        
        #expect(result == .granted)
        #expect(repository.currentStatusCallsCount == 1)
        #expect(repository.registerCallsCount == 1)
    }

    @Test func shouldDenyRegistration() async {
        let repository = RepositoryMock(currentStatus: .notDetermined, registrationResult: false)
        let sut = RegisterForNotifications(repository: repository)

        let result = await sut.execute(input: ())

        #expect(result == .denied)
        #expect(repository.currentStatusCallsCount == 1)
        #expect(repository.registerCallsCount == 1)
    }

    @Test("Should return currentStatus when it is different than notDetermined", arguments: [
        NotificationRegistrationStatus.denied,
        NotificationRegistrationStatus.granted
    ])
    func shouldReturnCurrentStatus(currentStatus: NotificationRegistrationStatus) async {
        let repository = RepositoryMock(currentStatus: currentStatus, registrationResult: true)
        let sut = RegisterForNotifications(repository: repository)

        let result = await sut.execute(input: ())

        #expect(result == currentStatus)
        #expect(repository.currentStatusCallsCount == 1)
        #expect(repository.registerCallsCount == 0)
    }

    @Test func statusShouldBeNotDeterminedIfRegistrationFails() async {
        let repository = RepositoryMock(
            currentStatus: .notDetermined,
            registrationResult: false,
            shouldFailRegistration: true
        )
        let sut = RegisterForNotifications(repository: repository)

        let result = await sut.execute(input: ())

        #expect(result == .notDetermined)
        #expect(repository.currentStatusCallsCount == 1)
        #expect(repository.registerCallsCount == 1)
    }
}


private final class RepositoryMock: NotificationsRegistrationStatusFetching, NotificationsRegistrationStatusCreating {
    enum RepositoryError: Error {
        case empty
    }

    private let currentStatus: NotificationRegistrationStatus
    private let registrationResult: Bool
    private let shouldFailRegistration: Bool
    private(set) var currentStatusCallsCount = 0
    private(set) var registerCallsCount = 0

    init(
        currentStatus: NotificationRegistrationStatus,
        registrationResult: Bool,
        shouldFailRegistration: Bool = false
    ) {
        self.currentStatus = currentStatus
        self.registrationResult = registrationResult
        self.shouldFailRegistration = shouldFailRegistration
    }

    func currentStatus() async -> NotificationRegistrationStatus {
        currentStatusCallsCount += 1
        return currentStatus
    }

    func registerForNotifications() async throws -> Bool {
        registerCallsCount += 1
        if shouldFailRegistration {
            throw RepositoryError.empty
        }
        return registrationResult
    }
}
