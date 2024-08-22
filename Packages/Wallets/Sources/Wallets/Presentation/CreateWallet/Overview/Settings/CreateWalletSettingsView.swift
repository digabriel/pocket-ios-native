//
//  CreateWalletSettingsView.swift
//  Wallets
//
//  Created by Dimas Gabriel on 8/21/24.
//

import SwiftUI
import Styleguide

struct CreateWalletSettingsView: View {
    @Environment(CreateWalletModel.self) private var createModel

    var body: some View {
        @Bindable var createModel = createModel

        VStack(alignment: .leading, spacing: Dimensions.shared.ten) {
            Text("Settings")
                .textCase(.uppercase)
                .font(Font.text.tiniest)
                .foregroundStyle(Color.regular.black)
                .kerning(1.2)

            VStack(spacing: Dimensions.shared.fourteen) {
                ForEach($createModel.settings, id: \.identifier) { setting in
                    Toggle(
                        title: setting.wrappedValue.title,
                        description: setting.wrappedValue.description,
                        isEnabled: setting.isEnabled
                    )
                    .tint(Color.regular.black)
                }
            }
        }
    }
}

#Preview {
    CreateWalletSettingsView()
        .environment(CreateWalletModel.preview())
}
