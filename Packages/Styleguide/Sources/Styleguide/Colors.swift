//
//  Colors.swift
//
//
//  Created by Dimas Gabriel on 6/19/24.
//

import SwiftUI
import Foundation

public extension Color {
    static let background = Background()
    static let regular = Regular()
    static let wallet = Wallet()

    struct Background: Sendable {
        public let pastel = Color(ColorResource.backgroundPastel)
        public let lightGray = Color(ColorResource.backgroundLightGray)
        public let darkPink = Color(ColorResource.backgroundDarkPink)
        public let lightPink = Color(ColorResource.backgroundLightPink)
    }

    struct Regular: Sendable {
        public let orange = Color(ColorResource.orange)
        public let black = Color(ColorResource.black)
        public let white = Color(ColorResource.white)
        public let gray = Color(ColorResource.gray)
        public let yellow = Color(ColorResource.yellow)
        public let dark = Color(ColorResource.dark)
        public let lightBlue = Color(ColorResource.lightBlue)
        public let pastelRed = Color(ColorResource.pastelRed)
        public let purple = Color(ColorResource.purple)
        public let lightGray = Color(ColorResource.lightGray)
        public let blueGreen = Color(ColorResource.blueGreen)
        public let pink = Color(ColorResource.pink)
        public let green = Color(ColorResource.green)
        public let darkGreen = Color(ColorResource.darkGreen)
        public let blue = Color(ColorResource.blue)
        public let red = Color(ColorResource.red)
        public let darkGray = Color(ColorResource.darkGray)
        public let softGray = Color(ColorResource.softGray)
    }

    struct Wallet: Sendable {
        public let accent = Color(ColorResource.walletsAccent)
    }
}
