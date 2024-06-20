//
//  OnboardingNotificationsView.swift
//  
//
//  Created by Dimas Gabriel on 6/20/24.
//

import SwiftUI
import Styleguide

public struct OnboardingNotificationsView: View {
    public var body: some View {
        VStack(spacing: Dimensions.shared.fourteen) {
            Spacer()

            Image("bell", bundle: .module)
            titleView
            notificationsView

            Spacer()

            CapsuleButton(title: "Continue") {}
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background.lightGray)
    }

    private var titleView: some View {
        VStack(spacing: Dimensions.shared.eight) {
            Text("A little nudge?")
                .foregroundStyle(Color.regular.black)
                .font(Font.title.largeRounded)

            Text("Users with notifications enabled are over 2x more likely to stick to their budgets")
                .foregroundStyle(Color.regular.gray)
                .font(Font.text.regular)
        }
        .multilineTextAlignment(.center)
    }

    private var notificationsView: some View {
        Text("TODO: Notifications card")
    }
}

#Preview {
    OnboardingNotificationsView()
}
