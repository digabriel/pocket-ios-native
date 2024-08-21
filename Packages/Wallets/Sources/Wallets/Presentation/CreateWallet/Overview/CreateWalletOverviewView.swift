//
//  CreateWalletOverviewView.swift
//  Wallets
//
//  Created by Dimas Gabriel on 8/12/24.
//

import SwiftUI
import Styleguide

struct CreateWalletOverviewView: View {
    @State private var viewModel: ViewModel
    @Binding private var navigationPath: [CreateWalletNavigationStack.Screen]

    init(viewModel: ViewModel, navigationPath: Binding<[CreateWalletNavigationStack.Screen]>) {
        self._viewModel = .init(initialValue: viewModel)
        self._navigationPath = navigationPath
    }

    var body: some View {
        VStack(spacing: Dimensions.shared.ten) {
            headerView
            nameView
            balanceView
            settingsView
            Spacer()
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
        CreateWalletNameView(viewModel: viewModel.nameViewModel)
    }

    private var balanceView: some View {
        Box(shape: .rectangular) {
            CreateWalletBalanceOverviewView(viewModel: viewModel.balanceViewModel, navigationPath: $navigationPath)
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
    let model = CreateWalletModel.preview()
    return CreateWalletOverviewView(viewModel: .init(model: model), navigationPath: .constant([]))
}
