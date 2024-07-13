//
//  WalletsMainView.swift
//  
//
//  Created by Dimas Gabriel on 6/30/24.
//

import SwiftUI
import Styleguide
import SwiftData

public struct WalletsMainView: View {
    @State private var viewModel: ViewModel
    @State private var scrollYOffset: CGFloat = 0
    @State private var headerHeight: CGFloat = 0
    @State private var isCreateWalletVisible = false

    public init(dependency: Dependency) {
        _viewModel = .init(initialValue: .init(dependency: dependency))
    }

    public var body: some View {
        ZStack(alignment: .topLeading) {
            ScrollView(showsIndicators: false) {
                VStack {
                    CircularTitledButton(
                        action: { isCreateWalletVisible = true },
                        icon: { Image(systemName: "plus") },
                        title: String(localized: "New Wallet")
                    )
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.top, headerHeight)
                .padding(Dimensions.shared.seventeen)
                .background(
                    GeometryReader { proxy in
                        Color.clear
                            .preference(
                                key: ScrollViewOffsetKey.self,
                                value: proxy.frame(in: .scrollView(axis: .vertical)).origin.y
                            )
                    }
                )
                .onPreferenceChange(ScrollViewOffsetKey.self) { offset in
                    scrollYOffset = offset
                }
            }

            GeometryReader { proxy in
                VStack {
                    navBar
                        .padding(.horizontal, Dimensions.shared.eight)
                        .padding(.top, Dimensions.shared.three)

                    WalletsSummaryView(viewModel: viewModel.childrenViewModels.walletsSummary)
                        .padding(.bottom, Dimensions.shared.five + scrollYOffset / 2.0)
                        .padding(.top, Dimensions.shared.one + scrollYOffset / 2.0)
                        .opacity(scrollYOffset < 0 ? 1.0 - ((scrollYOffset * -1) / 100.0) : 1)
                }
                .background(headerBackground)
                .background(
                    GeometryReader { proxy in
                        Color.clear
                            .preference(key: HeaderViewHeightKey.self, value: proxy.size.height)
                    }
                )

                .onPreferenceChange(HeaderViewHeightKey.self) { headerHeight in
                    self.headerHeight = headerHeight
                }
            }
        }
        .sheet(isPresented: $isCreateWalletVisible) {
            CreateWalletNavigationStack(viewModel: viewModel.childrenViewModels.createWallet)
        }
    }

    private var navBar: some View {
        ZStack {
            Text("WALLETS")
                .font(Font.text.small)
                .kerning(1)
                .foregroundStyle(Color.regular.white)

            HStack {
                Button {

                } label: {
                    Image(systemName: "gearshape")
                        .font(Font.button.regular)
                        .tint(Color.regular.white)
                }
                Spacer()
            }
        }
    }

    private var headerBackground: some View {
        LinearGradient(
            gradient: Gradient(colors: [Color.background.lightPink, Color.background.darkPink]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
            .shadow(radius: 10)
            .mask(Rectangle().padding(.bottom, -30))
            .ignoresSafeArea()
    }
}

#Preview {
    let dependency = WalletsMainView.Dependency(
        getWalletCategoriesUseCase: GetWalletCategoriesPreview(),
        getMoneyForWalletCategoryUseCase: GetMoneyForWalletCategoryPreview()
    )

    WalletsMainView(dependency: dependency)
}

private struct ScrollViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static let defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

private struct HeaderViewHeightKey: PreferenceKey {
    typealias Value = CGFloat
    static let defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}
