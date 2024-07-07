//
//  WalletsSummaryView.swift
//  
//
//  Created by Dimas Gabriel on 7/4/24.
//

import SwiftUI
import Styleguide
import SwiftData

struct WalletsSummaryView: View {
    @State private var viewModel: ViewModel
    @State private var currentPage: Int? = 0

    init(viewModel: ViewModel) {
        _viewModel = .init(initialValue: viewModel)
    }

    var body: some View {
        VStack(spacing: 0) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(viewModel.items) { item in
                        ItemView(item: item)
                    }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.paging)
            .scrollPosition(id: $currentPage)

            PageIndicator(numberOfPages: viewModel.items.count, currentPage: $currentPage)
        }
        .onAppear {
            Task {
                await viewModel.refresh()
            }
        }
    }

    private struct ItemView: View {
        let item: Model

        var body: some View {
            VStack(alignment: .center, spacing: Dimensions.shared.two) {
                Text(item.amount.formatted())
                    .font(Font.title.largerRounded)

                Text(item.title)
                    .textCase(.uppercase)
                    .font(Font.text.smaller)
                    .kerning(1)
            }
            .foregroundStyle(Color.regular.white)
            .containerRelativeFrame(.horizontal)
            .scrollTransition { content, phase in
                content
                    .scaleEffect(phase.isIdentity ? 1 : 0.4)
                    .opacity(phase.isIdentity ? 1: phase.value > 0 ? phase.value * -1 : phase.value)

            }
        }
    }
}

#Preview {
    let dependency = WalletsSummaryView.Dependency(
        getWalletCategoriesUseCase: GetWalletCategoriesPreview(),
        getMoneyForWalletCategoryUseCase: GetMoneyForWalletCategoryPreview()
    )

    WalletsSummaryView(viewModel: .init(dependency: dependency))
        .padding()
        .background(Color.red)
}
