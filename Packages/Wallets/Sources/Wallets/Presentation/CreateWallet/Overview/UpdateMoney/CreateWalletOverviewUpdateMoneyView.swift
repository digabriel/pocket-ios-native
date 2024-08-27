//
//  CreateWalletOverviewUpdateMoneyView.swift
//  Wallets
//
//  Created by Dimas Gabriel on 8/20/24.
//

import SwiftUI
import Styleguide

struct CreateWalletOverviewUpdateMoneyView: View {
    @Environment(\.dismiss) var dismiss
    @FocusState private var isTextFieldFocused: Bool

    let title: String
    let isNegativeInputSupported: Bool
    @Binding var inputValue: Decimal

    var body: some View {
        VStack {
            CreateWalletNavigationHeaderView(
                title: title,
                leftButtonType: .back
            )

            Spacer()

            VStack(spacing: Dimensions.shared.fourteen) {
                CurrencyTextField(
                    value: $inputValue,
                    font: Font.title.largeRoundedUIKit,
                    color: UIColor(Color.regular.black),
                    isNegativeInputSupported: isNegativeInputSupported
                )
                    .background(Color.background.lightGray)
                    .clipShape(.rect(cornerRadius: 12))
                    .frame(height: 80)
                    .focused($isTextFieldFocused)

                CapsuleButton(title: "Save") { dismiss() }
            }
            .multilineTextAlignment(.center)
            .padding(.horizontal, Dimensions.shared.sixteen)

            Spacer()
        }
        .toolbar(.hidden)
        .onAppear {
            isTextFieldFocused = true
        }
    }
}

#Preview {
    CreateWalletOverviewUpdateMoneyView(
        title: "Update Balance",
        isNegativeInputSupported: true,
        inputValue: .constant(0)
    )
}
