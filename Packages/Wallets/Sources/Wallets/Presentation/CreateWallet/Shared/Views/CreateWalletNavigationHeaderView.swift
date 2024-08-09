//
//  CreateWalletNavigationHeaderView.swift
//  Wallets
//
//  Created by Dimas Gabriel on 8/9/24.
//

import SwiftUI
import Styleguide

struct CreateWalletNavigationHeaderView: View {
    let title: String
    let leftButtonType: LeftButtonType

    @Environment(\.dismiss) var dismiss

    var body: some View {
        HStack {
            Button { dismiss() } label: {
                Image(systemName: leftIconName)
            }
            .font(Font.text.regular)

            Spacer()

            Text(title)
                .textCase(.uppercase)

            Spacer()
        }
        .foregroundStyle(Color.regular.gray)
        .font(Font.text.smaller)
        .kerning(1)
        .padding(Dimensions.shared.eight)
    }

    private var leftIconName: String {
        switch leftButtonType {
        case .dismiss:
            return "xmark"
        case .back:
            return "chevron.left"
        }
    }
}

extension CreateWalletNavigationHeaderView {
    enum LeftButtonType {
        case dismiss
        case back
    }
}

#Preview {
    CreateWalletNavigationHeaderView(title: "Title", leftButtonType: .dismiss)
}
