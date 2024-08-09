//
//  MoneyTests.swift
//  CommonDomain
//
//  Created by Dimas Gabriel on 8/8/24.
//

import Testing
@testable import CommonDomain

struct MoneyTests {
    @Test func moneyFormatting() {
        let money = Money(amount: 1, currency: .USD)
        #expect(money.formatted() == "$1")

        let money2 = Money(amount: 1.01, currency: .USD)
        #expect(money2.formatted() == "$1.01")

        let money3 = Money(amount: 1.10, currency: .USD)
        #expect(money3.formatted() == "$1.1")
    }

    @Test func moneySumWithSameCurrency() throws {
        let money1 = Money(amount: 1, currency: .USD)
        let money2 = Money(amount: 0.1, currency: .USD)

        let sum = try money1 + money2

        #expect(sum.amount == 1.1)
    }

    @Test func moneySumWithDifferentCurrency() throws {
        let money1 = Money(amount: 1, currency: .USD)
        let money2 = Money(amount: 0.1, currency: .BRL)

        #expect(throws: MoneyError.operationOverDifferentCurrencies) {
            try money1 + money2
        }
    }

    @Test func moneyEquality() {
        let money1 = Money(amount: 1, currency: .USD)
        let money2 = Money(amount: 0.1, currency: .BRL)
        let money3 = Money(amount: 1, currency: .BRL)
        let money4 = Money(amount: 1, currency: .USD)

        #expect(money1 == money4)
        #expect(money1 != money3)
        #expect(money3 != money4)
        #expect(money2 != money3)
    }
}
