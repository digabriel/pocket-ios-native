//
//  CreateWalletNameView.swift
//  Wallets
//
//  Created by Dimas Gabriel on 8/19/24.
//

import SwiftUI
import Styleguide

struct CreateWalletNameView: View {
    @Environment(CreateWalletModel.self) private var createModel

    var body: some View {
        @Bindable var createModel = createModel

        VStack(spacing: Dimensions.shared.eight) {
            HStack(spacing: Dimensions.shared.six) {
                WalletIconView(iconName: createModel.iconName, backgroundColor: createModel.iconBackgroundColor)
                textField
            }

            WalletIconBackgroundPicker(selected: $createModel.iconBackgroundColor)
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

    @ViewBuilder private var textField: some View {
        @Bindable var createModel = createModel

        VStack(alignment: .leading, spacing: Dimensions.shared.one) {
            Text("Name")
                .textCase(.uppercase)
                .font(Font.text.tiniest)
                .foregroundStyle(Color.regular.black)
                .kerning(1.2)

            TextField("", text: $createModel.name)
                .font(Font.text.large)
        }
        .padding(.top, Dimensions.shared.one)
    }
}

#Preview {
    CreateWalletNameView()
        .environment(CreateWalletModel.preview())
}
