//
//  OnboardingLandingView.swift
//  
//
//  Created by Dimas Gabriel on 6/19/24.
//

import SwiftUI
import Styleguide

public struct OnboardingLandingView: View {
    public init() {}

    public var body: some View {
        Text("Onboarding Landing")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.background.pastel)
    }
}

#Preview {
    OnboardingLandingView()
}
