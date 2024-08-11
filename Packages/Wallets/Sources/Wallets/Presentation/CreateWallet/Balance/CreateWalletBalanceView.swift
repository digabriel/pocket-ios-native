//
//  CreateWalletBalanceView.swift
//  Wallets
//
//  Created by Dimas Gabriel on 8/9/24.
//

import SwiftUI
import Styleguide

struct CreateWalletBalanceView: View {
    @State private var viewModel: ViewModel

    init(viewModel: ViewModel) {
        _viewModel = .init(initialValue: viewModel)
    }

    var body: some View {
        VStack {
            CreateWalletNavigationHeaderView(
                title: viewModel.title,
                leftButtonType: .back
            )

            Spacer()

            VStack(spacing: Dimensions.shared.fourteen) {
                Text(viewModel.inputPlaceholderText)
                    .font(Font.title.regularRounded2)
                    .foregroundStyle(Color.regular.black)

                CurrencyTextField(
                    value: $viewModel.inputValue,
                    font: Font.title.largeRoundedUIKit,
                    color: UIColor(Color.regular.black)
                )
                    .background(Color.background.lightGray)
                    .clipShape(.rect(cornerRadius: 12))
                    .frame(height: 80)

                CapsuleButton(title: "Continue") {

                }

            }
            .multilineTextAlignment(.center)
            .padding(.horizontal, Dimensions.shared.sixteen)

            Spacer()
        }
        .toolbar(.hidden)
    }
}

#Preview {
    let viewModel = CreateWalletBalanceView.ViewModel(model: .preview())
    CreateWalletBalanceView(viewModel: viewModel)
}
