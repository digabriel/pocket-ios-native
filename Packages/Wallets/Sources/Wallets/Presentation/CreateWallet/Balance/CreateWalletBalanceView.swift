//
//  CreateWalletBalanceView.swift
//  Wallets
//
//  Created by Dimas Gabriel on 8/9/24.
//

import SwiftUI
import Styleguide

struct CreateWalletBalanceView: View {
    let screen: CreateWalletNavigationStack.Screen
    @Binding private var navigationPath: [CreateWalletNavigationStack.Screen]
    @Environment(CreateWalletModel.self) var createModel

    init(screen: CreateWalletNavigationStack.Screen, navigationPath: Binding<[CreateWalletNavigationStack.Screen]>) {
        _navigationPath = navigationPath
        self.screen = screen
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
                    Text(inputPlaceholderText)
                        .font(Font.title.regularRounded2)
                        .foregroundStyle(Color.regular.black)

                    Text(descriptionText)
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
                        navigateNext()
                    }
                }
            }
            .multilineTextAlignment(.center)
            .padding(.horizontal, Dimensions.shared.sixteen)

            Spacer()
        }
        .toolbar(.hidden)
    }

    private var inputProperty: Binding<Decimal> {
        @Bindable var createModel = createModel

        switch screen {
        case .initialBalance:
            return $createModel.initialBalanceAmount
        case .debtLeftToPayBalance:
            return $createModel.leftToPayBalanceAmount
        default:
            return .constant(0)
        }
    }

    private func navigateNext() {
        switch screen {
        case .initialBalance:
            navigationPath.append(createModel.walletCategory == .debt ? .debtLeftToPayBalance : .overview)
        case .debtLeftToPayBalance:
            navigationPath.append(.overview)
        default: return
        }
    }
}

private extension CreateWalletBalanceView {
    var inputPlaceholderText: String {
        switch createModel.walletCategory {
        case .spending, .savings:
            String(localized: "Current balance")
        case .debt:
            switch screen {
            case .initialBalance:
                String(localized: "How much was the debt from the start?")
            case .debtLeftToPayBalance:
                String(localized: "How much is left to pay?")
            default:
                ""
            }
        }
    }

    var descriptionText: String {
        switch createModel.walletCategory {
        case .spending, .savings:
            String(localized: "You can estimate now and change it whenever you want")
        case .debt:
            switch screen {
            case .initialBalance:
                String(localized: "Provide the amount of debt when you acquired it.")
            case .debtLeftToPayBalance:
                String(localized: "Provide the amount of debt that you still have to pay")
            default:
                ""
            }
        }
    }
}

private extension WalletCategory {

}

#Preview {
    CreateWalletBalanceView(screen: .initialBalance, navigationPath: .constant([.initialBalance]))
        .environment(CreateWalletModel.preview())
}
