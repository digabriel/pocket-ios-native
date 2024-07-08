//
//  CreateWalletNavigationStack.swift
//  
//
//  Created by Dimas Gabriel on 7/7/24.
//

import SwiftUI
import Styleguide

struct CreateWalletNavigationStack: View {
    @State private var viewModel: ViewModel
    @Environment(\.dismiss) var dismiss

    init(viewModel: ViewModel) {
        _viewModel = .init(initialValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: Dimensions.shared.five) {
                headerView
                pageSelectorView
            }
            .task { await viewModel.refresh() }
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

    private var pageSelectorView: some View {
        VStack(spacing: 0) {
            HorizontalPageSelector(
                items: viewModel.sections.map { $0.title },
                currentIndex: $viewModel.currentSectionIndex
            )
            .foregroundStyle(Color.regular.gray)
            .font(Font.text.smaller)
            .kerning(0.8)
            .tint(Color.wallet.accent)

            LinearGradient(colors: [.black.opacity(0.05), .clear], startPoint: .top, endPoint: .bottom)
                .frame(height: 8)
        }

    }
}

#Preview {
    let dependency = CreateWalletNavigationStack.Dependency(getWalletCategoriesUseCase: GetWalletCategoriesPreview())
    CreateWalletNavigationStack(viewModel: .init(dependency: dependency))
}
