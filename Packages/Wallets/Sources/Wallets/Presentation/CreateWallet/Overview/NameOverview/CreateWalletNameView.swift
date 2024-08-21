//
//  CreateWalletNameView.swift
//  Wallets
//
//  Created by Dimas Gabriel on 8/19/24.
//

import SwiftUI
import Styleguide

struct CreateWalletNameView: View {
    @State private var viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(spacing: Dimensions.shared.eight) {
            HStack(spacing: Dimensions.shared.six) {
                WalletIconView(iconName: viewModel.iconName, backgroundColor: viewModel.iconBackgroundColor)
                textField
            }

            WalletIconBackgroundPicker(selected: $viewModel.iconBackgroundColor)
                .padding(.horizontal, -Dimensions.shared.eight)
        }
        .padding(Dimensions.shared.eight)
        .background(
            Rectangle()
                .fill(Color.regular.white)
                .shadow(color: Color.regular.black.opacity(0.1), radius: 8)
                .mask(Rectangle().padding(.bottom, -20))
        )
    }

    private var textField: some View {
        VStack(alignment: .leading, spacing: Dimensions.shared.one) {
            Text("Name")
                .textCase(.uppercase)
                .font(Font.text.tiniest)
                .foregroundStyle(Color.regular.black)
                .kerning(1.2)

            TextField("", text: $viewModel.name)
                .font(Font.text.large)
        }
        .padding(.top, Dimensions.shared.one)
    }
}

#Preview {
    CreateWalletNameView(viewModel: .init(model: .preview()))
}

extension CreateWalletNameView {
    @MainActor @Observable final class ViewModel {
        var name: String
        let iconName: String
        var iconBackgroundColor: Color

        init(model: CreateWalletModel) {
            self.name = model.name
            self.iconName = model.iconName
            self.iconBackgroundColor = model.iconBackgroundColor
        }
    }
}
