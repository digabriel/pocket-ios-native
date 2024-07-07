//
//  Money.swift
//  
//
//  Created by Dimas Gabriel on 7/6/24.
//

import Foundation

public struct Money: Equatable {
    public let amount: Decimal

    public init(amount: Decimal) {
        self.amount = amount
    }

    public static var zero: Money = Money(amount: 0)

    public static func +(lhs: Self, rhs: Self) -> Money {
        return .init(amount: lhs.amount + rhs.amount)
    }

    public static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.amount == rhs.amount
    }

    public func formatted() -> String {
        "$\(amount / 100.0)"
    }
}
