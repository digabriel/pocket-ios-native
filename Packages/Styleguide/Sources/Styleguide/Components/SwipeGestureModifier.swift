//
//  SwipeGestureModifier.swift
//  Styleguide
//
//  Created by Dimas Gabriel on 7/14/24.
//

import SwiftUI

public struct SwipeGestureViewModifier: ViewModifier {
    public enum Direction {
        case up, down, left, right
    }

    let onEnded: (Direction) -> Void

    public func body(content: Content) -> some View {
        content
            .gesture(
                DragGesture(minimumDistance: 20, coordinateSpace: .global)
                    .onEnded { value in
                        let horizontalAmount = value.translation.width
                        let verticalAmount = value.translation.height

                        if abs(horizontalAmount) > abs(verticalAmount) {
                            onEnded(horizontalAmount < 0 ? .left : .right)
                        } else {
                            onEnded(verticalAmount < 0 ? .up : .down)
                        }
                    }
            )
    }
}

public extension View {
    func onSwipeGesture(onEnded: @escaping (SwipeGestureViewModifier.Direction) -> Void) -> some View {
        modifier(SwipeGestureViewModifier(onEnded: onEnded))
    }
}
