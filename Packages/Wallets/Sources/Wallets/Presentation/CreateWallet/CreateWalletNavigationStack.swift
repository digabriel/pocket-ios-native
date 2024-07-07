//
//  CreateWalletNavigationStack.swift
//  
//
//  Created by Dimas Gabriel on 7/7/24.
//

import SwiftUI
import Styleguide

struct CreateWalletNavigationStack: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            headerView
        }
    }

    private var headerView: some View {
        HStack {
            Button { dismiss() } label: {
                Image(systemName: "xmark")
            }
            .font(Font.text.regular)

            Spacer()

            Text("Create Wallet")
                .textCase(.uppercase)

            Spacer()
        }
        .foregroundStyle(Color.regular.gray)
        .font(Font.text.smaller)
        .kerning(1)
        .padding(Dimensions.shared.eight)
    }
}

#Preview {
    CreateWalletNavigationStack()
}
