//
//  CreateWalletBalanceView.swift
//  Wallets
//
//  Created by Dimas Gabriel on 8/9/24.
//

import SwiftUI

struct CreateWalletBalanceView: View {
    @State private var viewModel: ViewModel

    init(viewModel: ViewModel) {
        _viewModel = .init(initialValue: viewModel)
    }

    var body: some View {
        VStack {
            CreateWalletNavigationHeaderView(
                title: viewModel.title,
                leftButtonType: .back
            )

            Spacer()
        }
        .toolbar(.hidden)
    }
}

#Preview {
    let viewModel = CreateWalletBalanceView.ViewModel(model: .preview())
    CreateWalletBalanceView(viewModel: viewModel)
}
