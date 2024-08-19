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
        HStack(spacing: Dimensions.shared.six) {
            WalletIconView(iconName: viewModel.iconName, backgroundColor: viewModel.iconBackgroundColor)
            textField
        }
    }

    private var textField: some View {
        VStack(alignment: .leading, spacing: Dimensions.shared.one) {
            Text("Name")
                .textCase(.uppercase)
                .font(Font.text.tiny)
                .foregroundStyle(Color.regular.black)

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
        let iconBackgroundColor: Color

        init(model: CreateWalletModel) {
            self.name = model.name
            self.iconName = model.iconName
            self.iconBackgroundColor = model.iconBackgroundColor
        }
    }
}
