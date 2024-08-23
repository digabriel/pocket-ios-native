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
    @State private var navigationPath = [Screen]()
    @Environment(\.dismiss) var dismiss

    init(viewModel: ViewModel) {
        _viewModel = .init(initialValue: viewModel)
    }

    var body: some View {
        NavigationStack(path: $navigationPath) {
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
            .navigationDestination(for: Screen.self) { screen in
                switch screen {
                case .initialBalance, .debtLeftToPayBalance:
                    CreateWalletBalanceView(screen: screen, navigationPath: $navigationPath)
                case .overview:
                    CreateWalletOverviewView(navigationPath: $navigationPath)
                case .setMoney(let title, let inputValue):
                    CreateWalletOverviewUpdateMoneyView(title: title, inputValue: inputValue)
                }
            }
        }
        .environment(viewModel.createModel)
    }

    private var headerView: some View {
        CreateWalletNavigationHeaderView(
            title: "Create Wallet",
            leftButtonType: .dismiss
        )
    }

    private var pageSelectorView: some View {
        VStack(spacing: 0) {
            HorizontalPageSelector(
                items: viewModel.sections.map { $0.title },
                currentIndex: $viewModel.currentSectionIndex
            )
            .textCase(.uppercase)
            .foregroundStyle(Color.regular.gray)
            .font(Font.text.tiny)
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
                    .onTapGesture {
                        viewModel.selectItem(item: item)
                        navigationPath.append(.initialBalance)
                    }
                Divider()
            }
        }
    }

    private func itemView(item: CreateWalletNavigationStack.SectionItem) -> some View {
        HStack(spacing: Dimensions.shared.six) {
            WalletIconView(iconName: item.iconName, backgroundColor: item.iconBackgroundColor)

            VStack(alignment: .leading, spacing: Dimensions.shared.two) {
                Text(item.title)
                    .textCase(.uppercase)
                    .font(Font.title.smallBold)
                    .foregroundStyle(Color.regular.black)
                    .kerning(1.2)

                Text(item.description)
                    .font(Font.text.small)
                    .foregroundStyle(Color.regular.softGray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .kerning(0.7)
            }
        }
        .padding(.vertical, Dimensions.shared.eight)
    }
}

extension CreateWalletNavigationStack {
    enum Screen: Hashable {
        case initialBalance
        case debtLeftToPayBalance
        case overview
        case setMoney(title: String, inputValue: Binding<Decimal>)
    }
}

#Preview {
    let dependency = CreateWalletNavigationStack.Dependency(getWalletCategoriesUseCase: GetWalletCategoriesPreview())
    CreateWalletNavigationStack(viewModel: .init(dependency: dependency))
}

extension Binding: @retroactive Equatable where Value == Decimal {
    public static func == (lhs: Binding<Decimal>, rhs: Binding<Decimal>) -> Bool {
        return lhs.wrappedValue == rhs.wrappedValue
    }
}

extension Binding: @retroactive Hashable where Value == Decimal {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(wrappedValue)
    }
}
