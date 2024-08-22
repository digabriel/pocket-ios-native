//
//  CreateWalletBalanceView.swift
//  Wallets
//
//  Created by Dimas Gabriel on 8/9/24.
//

import SwiftUI
import Styleguide

struct CreateWalletBalanceView: View {
    @Binding private var navigationPath: [CreateWalletNavigationStack.Screen]
    @Environment(CreateWalletModel.self) var createModel

    init(navigationPath: Binding<[CreateWalletNavigationStack.Screen]>) {
        _navigationPath = navigationPath
    }

    var body: some View {
        VStack {
            CreateWalletNavigationHeaderView(
                title: createModel.name,
                leftButtonType: .back
            )

            Spacer()

            VStack(spacing: Dimensions.shared.nineteen) {
                VStack(spacing: Dimensions.shared.one) {
                    Text(createModel.walletCategory.inputPlaceholderText)
                        .font(Font.title.regularRounded2)
                        .foregroundStyle(Color.regular.black)

                    Text(createModel.walletCategory.descriptionText)
                        .font(Font.text.small)
                        .foregroundStyle(Color.regular.softGray)
                }

                VStack(spacing: Dimensions.shared.fourteen) {
                    CurrencyTextField(
                        value: inputProperty,
                        font: Font.title.largeRoundedUIKit,
                        color: UIColor(Color.regular.black)
                    )
                        .background(Color.background.lightGray)
                        .clipShape(.rect(cornerRadius: 12))
                        .frame(height: 80)

                    CapsuleButton(title: "Continue") {
                        navigationPath.append(.overview)
                    }
                }
            }
            .multilineTextAlignment(.center)
            .padding(.horizontal, Dimensions.shared.sixteen)

            Spacer()
        }
        .toolbar(.hidden)
    }

    var inputProperty: Binding<Decimal> {
        @Bindable var createModel = createModel

        switch navigationPath.last {
        case .initialBalance:
            return $createModel.initialBalanceAmount
        default:
            return .constant(0)
        }
    }
}

private extension WalletCategory {
    var inputPlaceholderText: String {
        switch self {
        case .spending:
            String(localized: "Current balance")
        case .savings:
            String(localized: "Current balance")
        case .debt:
            String(localized: "How much was the debt from the start?")
        }
    }

    var descriptionText: String {
        switch self {
        case .spending:
            String(localized: "You can estimate now and change it whenever you want")
        case .savings:
            String(localized: "You can estimate now and change it whenever you want")
        case .debt:
            String(localized: "Provide the amount of debt when you acquired it.")
        }
    }
}

#Preview {
    CreateWalletBalanceView(navigationPath: .constant([.initialBalance]))
        .environment(CreateWalletModel.preview())
}
