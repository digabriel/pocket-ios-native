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

    struct Title {
        public var small: Font { Font.system(size: 16, weight: .medium) }
        public var smallRounded: Font { Font.system(size: 18, weight: .medium, design: .rounded) }
        public var regular: Font { Font.system(size: 24, weight: .bold) }
        public var large: Font { Font.system(size: 36, weight: .bold) }
        public var largeRounded: Font { Font.system(size: 36, weight: .semibold, design: .rounded) }
        public var largerRounded: Font { Font.system(size: 48, weight: .semibold, design: .rounded) }
    }
    
    struct Text {
        public var larger: Font { Font.system(size: 30) }
        public var regular: Font { Font.system(size: 18) }
        public var small: Font { Font.system(size: 16) }
        public var smaller: Font { Font.system(size: 14) }
    }

    struct Button {
        public var regular: Font { Font.system(size: 20, weight: .medium) }

    }
}


