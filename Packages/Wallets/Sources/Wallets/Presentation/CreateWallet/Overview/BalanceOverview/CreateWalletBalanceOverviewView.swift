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
    @Binding private var navigationPath: [CreateWalletNavigationStack.Screen]

    init(viewModel: ViewModel, navigationPath: Binding<[CreateWalletNavigationStack.Screen]>) {
        self._viewModel = .init(initialValue: viewModel)
        self._navigationPath = navigationPath
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
                    fieldView(field: field)
                        .onTapGesture { navigateToUpdate(field: field) }
                }
            }
        }
    }

    private func fieldView(field: ValueField) -> some View {
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

    private func navigateToUpdate(field: ValueField) {
        let fieldBinding = $viewModel.fields.first { $0.id == field.id }?.currentValue ?? .constant(0)
        navigationPath.append(.setMoney(title: field.title, inputValue: fieldBinding))
    }
}

#Preview {
    CreateWalletBalanceOverviewView(
        viewModel: .init(
            balanceType: .debt(startingDebt: .zero(currency: .USD), leftToPay: .zero(currency: .USD))
        ),
        navigationPath: .constant([])
    )
}
