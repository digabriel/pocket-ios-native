//
//  Money.swift
//  
//
//  Created by Dimas Gabriel on 7/6/24.
//

import Foundation

public struct Money: Equatable, Sendable {
    public let amount: Decimal
    public let currency: Currency

    public init(amount: Decimal, currency: Currency) {
        self.amount = amount
        self.currency = currency
    }

    public static func zero(currency: Currency) -> Money {
        Money(amount: 0, currency: currency)
    }

    public static func +(lhs: Self, rhs: Self) throws -> Money {
        guard lhs.currency == rhs.currency else {
            throw MoneyError.operationOverDifferentCurrencies
        }
        
        return .init(amount: lhs.amount + rhs.amount, currency: lhs.currency)
    }

    public static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.amount == rhs.amount && lhs.currency == rhs.currency
    }

    public func formatted() -> String {
        amount.formatted(.currency(code: currency.code).precision(.fractionLength(0...2)))
    }
}

public enum MoneyError: Error {
    case operationOverDifferentCurrencies
}
