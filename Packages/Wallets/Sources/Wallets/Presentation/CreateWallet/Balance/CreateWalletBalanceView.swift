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
    @Binding private var navigationPath: [CreateWalletNavigationStack.Screen]

    init(viewModel: ViewModel, navigationPath: Binding<[CreateWalletNavigationStack.Screen]>) {
        _viewModel = .init(initialValue: viewModel)
        _navigationPath = navigationPath
    }

    var body: some View {
        VStack {
            CreateWalletNavigationHeaderView(
                title: viewModel.title,
                leftButtonType: .back
            )

            Spacer()

            VStack(spacing: Dimensions.shared.nineteen) {
                VStack(spacing: Dimensions.shared.one) {
                    Text(viewModel.inputPlaceholderText)
                        .font(Font.title.regularRounded2)
                        .foregroundStyle(Color.regular.black)

                    Text(viewModel.descriptionText)
                        .font(Font.text.small)
                        .foregroundStyle(Color.regular.softGray)
                }

                VStack(spacing: Dimensions.shared.fourteen) {
                    CurrencyTextField(
                        value: $viewModel.inputValue,
                        font: Font.title.largeRoundedUIKit,
                        color: UIColor(Color.regular.black)
                    )
                        .background(Color.background.lightGray)
                        .clipShape(.rect(cornerRadius: 12))
                        .frame(height: 80)

                    CapsuleButton(title: "Continue") {
                        navigationPath.append(.overview(model: viewModel.updatedModel))
                    }
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
    CreateWalletBalanceView(viewModel: viewModel, navigationPath: .constant([]))
}
