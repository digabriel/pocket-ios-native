//
//  MainTabView.swift
//  Pocket
//
//  Created by Dimas Gabriel on 6/30/24.
//

import SwiftUI
import Wallets

struct MainTabView: View {
    var body: some View {
        TabView {
            Tab("Overview", image: "overview-tab-icon") { OverviewMainView() }
            Tab("Budget", image: "budget-tab-icon") { BudgetMainView() }
            Tab("Wallets", image: "wallets-tab-icon") { WalletsMainView() }
            Tab("Tools", image: "tools-tab-icon") { ToolsMainView() }
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
