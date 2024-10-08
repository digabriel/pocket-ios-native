//
//  Fonts.swift
//  
//
//  Created by Dimas Gabriel on 6/19/24.
//

import SwiftUI

public extension Font {
    static let title = Title()
    static let text = Text()
    static let button = Button()

    struct Title: Sendable {
        public var small: Font { Font.system(size: 15, weight: .medium) }
        public var smallBold: Font { Font.system(size: 15, weight: .bold) }
        public var smallRounded: Font { Font.system(size: 18, weight: .medium, design: .rounded) }
        public var regular: Font { Font.system(size: 24, weight: .bold) }
        public var regularRounded2: Font { Font.system(size: 30, weight: .semibold, design: .rounded) }
        public var large: Font { Font.system(size: 36, weight: .bold) }
        public var largeRounded: Font { Font.system(size: 36, weight: .semibold, design: .rounded) }
        public var largerRounded: Font { Font.system(size: 48, weight: .semibold, design: .rounded) }
    }

    struct Text: Sendable {
        public var larger: Font { Font.system(size: 30) }
        public var large: Font { Font.system(size: 24) }
        public var regular: Font { Font.system(size: 18) }
        public var small: Font { Font.system(size: 15) }
        public var smaller: Font { Font.system(size: 14) }
        public var tiny: Font { Font.system(size: 12) }
        public var tiniest: Font { Font.system(size: 10) }
    }

    struct Button: Sendable {
        public var regular: Font { Font.system(size: 20, weight: .medium) }

    }
}

public extension Font.Title {
    public var largeRoundedUIKit: UIFont {
        let systemFont = UIFont.systemFont(ofSize: 36, weight: .semibold)
        let font: UIFont

        if let descriptor = systemFont.fontDescriptor.withDesign(.rounded) {
            font = UIFont(descriptor: descriptor, size: 36)
        } else {
            font = systemFont
        }
        return font
    }
}
