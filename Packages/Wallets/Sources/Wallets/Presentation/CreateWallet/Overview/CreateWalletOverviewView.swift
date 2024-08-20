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
            Spacer()
        }
        .background(Color.background.lightGray)
        .navigationBarBackButtonHidden()
    }

    private var headerView: some View {
        CreateWalletNavigationHeaderView(title: String(localized: "NEW WALLET"), leftButtonType: .back)
            .background(
                Rectangle()
                    .fill(Color.regular.white)
                    .frame(height: 55)
                    .shadow(color: Color.regular.black.opacity(0.1), radius: 8)
                    .mask(Rectangle().padding(.bottom, -20))
            )
    }

    private var nameView: some View {
        CreateWalletNameView(viewModel: viewModel.nameViewModel)
    }

    private var balanceView: some View {
        CreateWalletBalanceOverviewView(viewModel: viewModel.balanceViewModel, navigationPath: $navigationPath)
            .padding(Dimensions.shared.eight)
            .background(
                Rectangle()
                    .fill(Color.regular.white)
                    .shadow(color: Color.regular.black.opacity(0.1), radius: 8)
                    .mask(Rectangle().padding(.bottom, -20))
            )
    }
}

#Preview {
    let model = CreateWalletModel.preview()
    return CreateWalletOverviewView(viewModel: .init(model: model), navigationPath: .constant([]))
}
