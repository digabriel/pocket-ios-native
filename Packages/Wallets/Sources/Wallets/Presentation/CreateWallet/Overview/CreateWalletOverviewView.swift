//
//  CreateWalletOverviewView.swift
//  Wallets
//
//  Created by Dimas Gabriel on 8/12/24.
//

import SwiftUI

struct CreateWalletOverviewView: View {
    @State private var viewModel: ViewModel

    init(viewModel: ViewModel) {
        self._viewModel = .init(initialValue: viewModel)
    }

    var body: some View {
        VStack {
            headerView
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
}

#Preview {
    let model = CreateWalletModel.preview()
    return CreateWalletOverviewView(viewModel: .init(model: model))
}
