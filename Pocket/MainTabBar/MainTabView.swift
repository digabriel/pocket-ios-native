//
//  MainTabView.swift
//  Pocket
//
//  Created by Dimas Gabriel on 6/30/24.
//

import SwiftUI
import Wallets

struct MainTabView: View {
    @Environment(SwiftUIWalletsPackage.self) private var walletsPackage

    var body: some View {
//        TabView {
//            Tab("Overview", image: "overview-tab-icon") { OverviewMainView() }
//            Tab("Budget", image: "budget-tab-icon") { BudgetMainView() }
//            Tab("Wallets", image: "wallets-tab-icon") { WalletsMainView() }
//            Tab("Tools", image: "tools-tab-icon") { ToolsMainView() }
//        }

        TabView {
            OverviewMainView()
                .tabItem {
                    Label("Overview", image: "overview-tab-icon")
                }

            BudgetMainView()
                .tabItem {
                    Label("Budget", image: "budget-tab-icon")
                }

            WalletsMainView(dependency: .init(
                getWalletCategoriesUseCase: walletsPackage.useCases.getWalletCategoriesUseCase,
                getMoneyForWalletCategoryUseCase: walletsPackage.useCases.getMoneyForWalletCategoryUseCase)
            )
                .tabItem {
                    Label("Wallets", image: "wallets-tab-icon")
                }

            ToolsMainView()
                .tabItem {
                    Label("Tools", image: "tools-tab-icon")
                }
        }
    }
}

struct OverviewMainView: View {
    var body: some View {
        Text("Overview")
    }
}

struct BudgetMainView: View {
    var body: some View {
        Text("Budget")
    }
}

struct ToolsMainView: View {
    var body: some View {
        Text("Tools")
    }
}
