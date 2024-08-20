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
    @State private var viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(alignment: .leading, spacing: Dimensions.shared.ten) {
            Text(viewModel.title)
                .textCase(.uppercase)
                .font(Font.text.tiny)
                .foregroundStyle(Color.regular.black)
                .kerning(1.2)

            VStack(alignment: .leading, spacing: Dimensions.shared.fourteen) {
                ForEach(viewModel.fields) { field in
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
            }
        }
    }
}

extension CreateWalletBalanceOverviewView {
    @MainActor @Observable final class ViewModel {
        private let balanceType: BalanceType

        let title: String
        let fields: [ValueField]

        init(balanceType: BalanceType) {
            self.balanceType = balanceType
            self.title = balanceType.title
            self.fields = balanceType.fields
        }
    }
}

extension CreateWalletBalanceOverviewView {
    struct ValueField: Identifiable {
        var id: String { title }
        let title: String
        let formattedValue: String
        let showsDisclosureIndicator: Bool
    }

    enum BalanceType {
        case spending(currentBalance: Money, goalBalance: Money?)
        case saving(currentBalance: Money, goalBalance: Money?)
        case debt(startingDebt: Money, leftToPay: Money)

        fileprivate var title: String {
            switch self {
            case .spending:
                return WalletCategory.spending.name
            case .saving:
                return WalletCategory.savings.name
            case .debt:
                return WalletCategory.debt.name
            }
        }

        fileprivate var fields: [ValueField] {
            switch self {
            case .spending(let currentBalance, let goalBalance), .saving(let currentBalance, let goalBalance):
                return [
                    .init(
                        title: String(localized: "Current balance"),
                        formattedValue: currentBalance.formatted(),
                        showsDisclosureIndicator: false
                    ),
                    .init(
                        title: goalBalance == nil ?
                            String(localized: "Set goal amount") : String(localized: "Goal amount"),
                        formattedValue: goalBalance?.formatted() ?? "",
                        showsDisclosureIndicator: goalBalance == nil
                    )
                ]
            case .debt(let startingDebt, let leftToPay):
                return [
                    .init(
                        title: String(localized: "Left to pay"),
                        formattedValue: leftToPay.formatted(),
                        showsDisclosureIndicator: false
                    ),
                    .init(
                        title: String(localized: "Starting debt"),
                        formattedValue: startingDebt.formatted(),
                        showsDisclosureIndicator: false
                    )
                ]
            }
        }
    }
}

#Preview {
    CreateWalletBalanceOverviewView(
        viewModel: .init(balanceType: .debt(startingDebt: .zero(currency: .USD), leftToPay: .zero(currency: .USD)))
    )
}
