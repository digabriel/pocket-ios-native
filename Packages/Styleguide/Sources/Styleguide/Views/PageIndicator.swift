//
//  PageIndicator.swift
//  
//
//  Created by Dimas Gabriel on 7/4/24.
//

import SwiftUI

public struct PageIndicator: View {
    let numberOfPages: Int
    @Binding var currentPage: Int?
    @State private var isPressing = false
    @State private var lastDragTranslation = 0.0

    public init(numberOfPages: Int, currentPage: Binding<Int?>) {
        self.numberOfPages = numberOfPages
        self._currentPage = currentPage
    }

    public var body: some View {
        HStack {
            ForEach(0..<numberOfPages, id: \.self) { index in
                Circle()
                    .frame(width: 8, height: 8)
                    .foregroundColor(index == currentPage ? Color.white: Color.white.opacity(0.5))
            }

        }
        .padding(5)
        .background(
            Capsule()
                .fill(isPressing ? .black.opacity(0.3) : .clear)
        )
        .padding()
        .contentShape(Rectangle())
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { value in
                    isPressing = true
                    let minTranslation = 10.0
                    guard abs(value.translation.width) > 0 else { return }
                    let translation = value.translation.width - lastDragTranslation
                    let newPage = (currentPage ?? 0) + Int(translation / minTranslation)
                    if newPage >= 0 && newPage < numberOfPages && newPage != currentPage {
                        currentPage = newPage
                        lastDragTranslation = value.translation.width
                    }
                }
                .onEnded { _ in
                    isPressing = false
                    lastDragTranslation = 0.0
                }
        )
        .animation(.easeInOut, value: currentPage)
        .animation(.easeInOut, value: isPressing)
    }
}
