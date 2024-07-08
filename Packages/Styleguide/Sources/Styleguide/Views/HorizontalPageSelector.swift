//
//  HorizontalPageSelector.swift
//  
//
//  Created by Dimas Gabriel on 7/7/24.
//

import SwiftUI

public struct HorizontalPageSelector: View {
    private let items: [String]
    @Binding private var currentIndex: Int
    @State private var itemWidth: CGFloat = 0

    public init(items: [String], currentIndex: Binding<Int>) {
        self.items = items
        self._currentIndex = currentIndex
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: Dimensions.shared.six) {
            HStack {
                ForEach(0..<items.count, id: \.self) { index in
                    Button {
                        currentIndex = index
                    } label: {
                        itemView(text: items[index])
                    }
                }
            }
            .background { geometryBackground }

            indicator
        }
        .onPreferenceChange(ItemWidthKey.self) { itemWidth in
            self.itemWidth = itemWidth
        }
    }

    private var indicator: some View {
        Rectangle()
            .fill(.tint)
            .frame(width: itemWidth, height: 3)
            .offset(x: CGFloat(currentIndex) * itemWidth)
            .animation(.spring(duration: 0.3), value: currentIndex)
    }

    private var geometryBackground: some View {
        GeometryReader { proxy in
            Color.clear
                .preference(
                    key: ItemWidthKey.self,
                    value: proxy.size.width / CGFloat(items.count)
                )
        }
    }

    private func itemView(text: String) -> some View {
        Text(text)
            .frame(maxWidth: .infinity)
    }
}

#Preview {
    StatefulPreviewWrapper(0) { 
        HorizontalPageSelector(items: ["First", "Second", "Third"], currentIndex: $0)
    }
}

private struct ItemWidthKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}
