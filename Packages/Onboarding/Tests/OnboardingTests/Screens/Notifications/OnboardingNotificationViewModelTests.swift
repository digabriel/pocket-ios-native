//
//  OnboardingNotificationViewModelTests.swift
//  
//
//  Created by Dimas Gabriel on 6/29/24.
//

import Testing
import SwiftData
import Notifications
@testable import Onboarding

final class OnboardingNotificationRegistrationViewModelTests {
    typealias SUT = OnboardingNotificationsView.ViewModel
    
    private var registerForNotificationsUseCaseMock: RegisterForNotificationUseCaseMock!

    private func makeSut(
        successStatus: NotificationRegistrationStatus = .granted,
        failureError: Error? = nil
    ) throws -> SUT {

        let outputStatus: RegisterForNotificationUseCaseMock.OutputStatus
        if let failureError {
            outputStatus = .failure(failureError)
        } else {
            outputStatus = .success(successStatus)
        }

        registerForNotificationsUseCaseMock = .init(outputStatus: outputStatus)

        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: NotificationBucket.self, configurations: configuration)
        let context = ModelContext(container)

        return .init(
            modelContext: context,
            dependency: .init(registerForNotifications: registerForNotificationsUseCaseMock)
        )
    }

    @Test func showCallNotificationRegistrationUseCase() async throws {
        let sut = try makeSut()
        await sut.registerForNotifications()
        #expect(registerForNotificationsUseCaseMock.executeCallsCount == 1)
    }

    @Test func shouldCaptureNotificationRegistrationStatus() async throws {
        let sut = try makeSut(successStatus: .denied)
        await sut.registerForNotifications()
        #expect(sut.notificationRegistrationStatus == .denied)
    }

    @Test func shouldCaptureNotificationRegistrationError() async throws {
        let sut = try makeSut(failureError: ErrorMock())
        await sut.registerForNotifications()
        #expect(sut.notificationRegistrationError is ErrorMock)
    }
}


private final class RegisterForNotificationUseCaseMock: RegisterForNotificationsUseCaseProtocol {
    enum OutputStatus {
        case success(NotificationRegistrationStatus)
        case failure(Error)
    }

    private let outputStatus: OutputStatus
    private(set) var executeCallsCount = 0

    init(outputStatus: OutputStatus) {
        self.outputStatus = outputStatus
    }

    func execute(input: ()) async throws -> NotificationRegistrationStatus {
        executeCallsCount += 1

        switch outputStatus {
        case .success(let notificationRegistrationStatus):
            return notificationRegistrationStatus
        case .failure(let error):
            throw error
        }
    }
}

private struct ErrorMock: Error {}
