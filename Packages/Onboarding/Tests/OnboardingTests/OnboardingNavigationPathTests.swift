//
//  OnboardingNavigationPathTests.swift
//  
//
//  Created by Dimas Gabriel on 6/26/24.
//

import Testing
@testable import Onboarding

struct OnboardingNavigationPathTests {
    @Test func navigationBetweenPaths() async throws {
        let initialPath = OnboardingNavigationPath.landing
        let notificationsPath = initialPath.next

        #expect(notificationsPath == OnboardingNavigationPath.notifications)
        #expect(notificationsPath?.next == nil)
    }
}
