//
//  CreateWalletOverviewView.swift
//  Wallets
//
//  Created by Dimas Gabriel on 8/12/24.
//

import SwiftUI
import Styleguide

struct CreateWalletOverviewView: View {
    @Binding private var navigationPath: [CreateWalletNavigationStack.Screen]
    @Environment(CreateWalletModel.self) var createModel

    init(navigationPath: Binding<[CreateWalletNavigationStack.Screen]>) {
        self._navigationPath = navigationPath
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(spacing: Dimensions.shared.ten) {
                    headerView
                    nameView
                    balanceView
                    settingsView
                    Spacer(minLength: CapsuleButton.defaultHeight)
                }
            }

            CapsuleButton(title: String(localized: "Save").uppercased()) {
                print("Save Wallet")
            }
            .padding(.horizontal, Dimensions.shared.ten)
        }
        .background(Color.background.lightGray)
        .navigationBarBackButtonHidden()
    }

    private var headerView: some View {
        Box(shape: .rectangular) {
            CreateWalletNavigationHeaderView(title: String(localized: "NEW WALLET"), leftButtonType: .back)
        }
    }

    private var nameView: some View {
        CreateWalletNameView()
    }

    private var balanceView: some View {
        Box(shape: .rectangular) {
            CreateWalletBalanceOverviewView(navigationPath: $navigationPath)
                .padding(Dimensions.shared.eight)
        }
    }

    private var settingsView: some View {
        Box(shape: .rectangular) {
            CreateWalletSettingsView()
                .padding(Dimensions.shared.eight)
        }
    }
}

#Preview {
    return CreateWalletOverviewView(navigationPath: .constant([]))
        .environment(CreateWalletModel.preview())
}
