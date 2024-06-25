//
//  OnboardingLandingView.swift
//  
//
//  Created by Dimas Gabriel on 6/19/24.
//

import SwiftUI
import Styleguide

public struct OnboardingLandingView: View {
    @EnvironmentObject private var mainViewModel: OnboardingMainView.ViewModel

    public var body: some View {
        VStack(alignment: .center, spacing: Dimensions.shared.ten) {
            Text("Welcome to Pocket")
                .font(Font.title.regular)
                .bold()
                .foregroundStyle(Color.regular.orange)

            Text("Let's get your finances in order")
                .font(Font.title.large)
                .bold()
                .foregroundStyle(Color.regular.black)

            Image("landingImage", bundle: .module)

            CapsuleButton(title: String(localized: "Continue"), action: {
                mainViewModel.navigateNext()
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
