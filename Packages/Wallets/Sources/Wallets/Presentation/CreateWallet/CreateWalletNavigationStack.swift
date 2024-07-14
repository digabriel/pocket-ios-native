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
                ScrollView(showsIndicators: false) {
                    tipTextView
                    listView
                }
                .padding(.horizontal, Dimensions.shared.eight)
            }
            .task { await viewModel.refresh() }
            .onSwipeGesture { direction in
                switch direction {
                case .up, .down: break
                case .right: viewModel.selectPreviousSection()
                case .left: viewModel.selectNextSection()
                }
            }
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
            .textCase(.uppercase)
            .foregroundStyle(Color.regular.gray)
            .font(Font.text.smaller)
            .kerning(0.8)
            .tint(Color.wallet.accent)

            LinearGradient(colors: [.black.opacity(0.03), .clear], startPoint: .top, endPoint: .bottom)
                .frame(height: 8)
                .background(Color.clear)
        }
    }

    @ViewBuilder private var tipTextView: some View {
        if let tipText = viewModel.activeSection?.tipText {
            ZStack {
                Text(tipText)
                    .font(Font.text.small)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(Dimensions.shared.eight)
            }
            .background(Color.background.lightGray)
            .cornerRadius(12)
        }
    }

    private var listView: some View {
        ForEach(viewModel.activeSection?.items ?? []) { item in
            VStack {
                itemView(item: item)
                Divider()
            }
        }
    }

    private func itemView(item: CreateWalletNavigationStack.SectionItem) -> some View {
        HStack(spacing: Dimensions.shared.six) {
            RoundedRectangle(cornerRadius: 18)
                .fill(item.iconBackgroundColor)
                .frame(width: 52, height: 52)
                .overlay {
                    Image("icons/\(item.iconName)", bundle: .module)
                }
                .shadow(color: item.iconBackgroundColor.opacity(0.5), radius: 2, y: 2)

            VStack(alignment: .leading, spacing: Dimensions.shared.two) {
                Text(item.title)
                    .textCase(.uppercase)
                    .font(Font.title.smallBold)
                    .foregroundStyle(Color.regular.black)
                    .kerning(0.7)

                Text(item.description)
                    .font(Font.text.small)
                    .foregroundStyle(Color.regular.softGray)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(.vertical, Dimensions.shared.eight)
    }
}

#Preview {
    let dependency = CreateWalletNavigationStack.Dependency(getWalletCategoriesUseCase: GetWalletCategoriesPreview())
    CreateWalletNavigationStack(viewModel: .init(dependency: dependency))
}
