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
        VStack(alignment: .center, spacing: Dimensions.shared.normal) {
            Text("Welcome to Pocket")
                .font(Font.titleFont)
                .bold()
                .foregroundStyle(Color.regular.orange)

            Text("Let's get your finances in order")
                .font(Font.largeTitleFont)
                .bold()
                .foregroundStyle(Color.regular.black)

            Image("landingImage", bundle: .module)

            CapsuleButton(title: String(localized: "Continue"), action: {
                
            })
            .padding(.top, -50)
        }
        .multilineTextAlignment(.center)
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background.pastel)
    }
}

#Preview {
    OnboardingLandingView()
}
