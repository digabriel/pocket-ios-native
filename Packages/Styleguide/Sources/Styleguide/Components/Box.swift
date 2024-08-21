//
//  Box.swift
//  Styleguide
//
//  Created by Dimas Gabriel on 8/21/24.
//

import SwiftUI

public struct Box<Content: View>: View {
    let shape: Shape
    @ViewBuilder let content: Content

    public init(shape: Shape = .rounded, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.shape = shape
    }

    public var body: some View {
        switch shape {
        case .rounded:
            roundedBox
        case .rectangular:
            rectangularBox
        }
    }

    private var rectangularBox: some View {
        content
            .background(
                Rectangle()
                    .fill(Color.regular.white)
                    .shadow(color: Color.regular.black.opacity(0.1), radius: 8)
                    .mask(Rectangle().padding(.bottom, -20))
            )
    }

    private var roundedBox: some View {
        content
            .padding(.all, Dimensions.shared.fourteen)
            .background(Color.regular.white)
            .cornerRadius(16)
            .shadow(color: Color.regular.black.opacity(0.25), radius: 10, y: 4)
    }
}

public extension Box {
    enum Shape {
        case rounded, rectangular
    }
}

#Preview {
    Box {
        Text("Rounded Box")
    }

    Box(shape: .rectangular) {
        Text("Rounded Box")
            .frame(maxWidth: .infinity)
    }
}
