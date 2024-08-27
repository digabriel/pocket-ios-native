//
//  CreateWalletBalanceView.swift
//  Wallets
//
//  Created by Dimas Gabriel on 8/20/24.
//

import SwiftUI
import CommonDomain
import Styleguide

struct CreateWalletBalanceOverviewView: View {
    @Binding private var navigationPath: [CreateWalletNavigationStack.Screen]
    @Environment(CreateWalletModel.self) private var createModel

    init(navigationPath: Binding<[CreateWalletNavigationStack.Screen]>) {
        self._navigationPath = navigationPath
    }

    var body: some View {
        VStack(alignment: .leading, spacing: Dimensions.shared.ten) {
            Text(createModel.walletCategory.name)
                .textCase(.uppercase)
                .font(Font.text.tiniest)
                .foregroundStyle(Color.regular.black)
                .kerning(1.2)

            VStack(alignment: .leading, spacing: Dimensions.shared.fourteen) {
                ForEach(allBalanceFields, id: \.title) { field in
                    fieldView(field: field)
                        .onTapGesture { navigateToUpdate(field: field) }
                }
            }
        }
    }

    private func fieldView(field: BalanceField) -> some View {
        HStack {
            Text(field.title)
                .font(Font.text.small)
                .kerning(0.8)

            Spacer()

            if field.showsDisclosureIndicator {
                Image(systemName: "chevron.right")
            } else {
                Text(field.formattedValue)
                    .font(Font.text.regular)
            }
        }
        .foregroundStyle(Color.regular.black)
    }

    private func navigateToUpdate(field: BalanceField) {
        navigationPath
            .append(
                .setMoney(
                    title: field.title,
                    inputValue: field.balanceAmount,
                    isNegativeInputSupported: field.isNegativeInputSupported
                )
            )
    }
}

extension CreateWalletBalanceOverviewView {
    struct BalanceField {
        let title: String
        let currency: Currency
        let showsDisclosureIndicator: Bool
        let isNegativeInputSupported: Bool
        var balanceAmount: Binding<Decimal>

        var formattedValue: String {
            Money(amount: balanceAmount.wrappedValue, currency: currency).formatted()
        }
    }

    var allBalanceFields: [BalanceField] {
        @Bindable var bindableModel = createModel

        switch createModel.walletCategory {
        case .debt:
            return [
                .init(
                    title: String(localized: "Left to pay"),
                    currency: createModel.currency,
                    showsDisclosureIndicator: false,
                    isNegativeInputSupported: false,
                    balanceAmount: $bindableModel.leftToPayBalanceAmount
                ),
                .init(
                    title: String(localized: "Starting debt"),
                    currency: createModel.currency,
                    showsDisclosureIndicator: false,
                    isNegativeInputSupported: false,
                    balanceAmount: $bindableModel.initialBalanceAmount
                )
            ]
        case .spending:
            let hasGoalAmount = createModel.hasGoalBalanceAmount
            return [
                .init(
                    title: String(localized: "Current balance"),
                    currency: createModel.currency,
                    showsDisclosureIndicator: false,
                    isNegativeInputSupported: true,
                    balanceAmount: $bindableModel.initialBalanceAmount
                ),
                .init(
                    title: hasGoalAmount ? String(localized: "Goal amount") : String(localized: "Set Goal amount"),
                    currency: createModel.currency,
                    showsDisclosureIndicator: !hasGoalAmount,
                    isNegativeInputSupported: false,
                    balanceAmount: $bindableModel.goalBalanceAmount
                )
            ]
        case .savings:
            let hasGoalAmount = createModel.hasGoalBalanceAmount
            return [
                .init(
                    title: String(localized: "Current balance"),
                    currency: createModel.currency,
                    showsDisclosureIndicator: false,
                    isNegativeInputSupported: true,
                    balanceAmount: $bindableModel.initialBalanceAmount
                ),
                .init(
                    title: hasGoalAmount ? String(localized: "Goal amount") : String(localized: "Set Goal amount"),
                    currency: createModel.currency,
                    showsDisclosureIndicator: !hasGoalAmount,
                    isNegativeInputSupported: false,
                    balanceAmount: $bindableModel.goalBalanceAmount
                )
            ]
        }
    }
}

#Preview {
    CreateWalletBalanceOverviewView(navigationPath: .constant([.overview]))
        .environment(CreateWalletModel.preview())
}
