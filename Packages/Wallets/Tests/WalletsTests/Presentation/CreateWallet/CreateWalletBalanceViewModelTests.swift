//
//  CreateWalletBalanceViewModelTests.swift
//  Wallets
//
//  Created by Dimas Gabriel on 8/9/24.
//

import Testing
import CommonDomain
@testable import Wallets

@MainActor
struct CreateWalletBalanceViewModelTests {
    private func makeSut(model: CreateWalletModel = .mock()) -> CreateWalletBalanceView.ViewModel {
        return .init(model: model)
    }

    @Test func tit5leShouldMatchModelName() {
        let expectedTitle = "My Beautiful Title"
        let model = CreateWalletModel.mock(name: expectedTitle)

        let sut = makeSut(model: model)

        #expect(sut.title == expectedTitle)
    }

    @Test func inputPlaceholderTextForDebtCategory() {
        let expectedText = "How much was the debt from the start?"
        let model = CreateWalletModel.mock(category: .debt)

        let sut = makeSut(model: model)

        #expect(sut.inputPlaceholderText == expectedText)
    }

    @Test func inputPlaceholderTextForSpendingCategory() {
        let expectedText = "Current balance"
        let model = CreateWalletModel.mock(category: .spending)

        let sut = makeSut(model: model)

        #expect(sut.inputPlaceholderText == expectedText)
    }

    @Test func inputPlaceholderTextForSavingsCategory() {
        let expectedText = "Current balance"
        let model = CreateWalletModel.mock(category: .savings)

        let sut = makeSut(model: model)

        #expect(sut.inputPlaceholderText == expectedText)
    }

    @Test func descriptionTextForDebtCategory() {
        let expectedText = "Provide the amount of debt when you acquired it."
        let model = CreateWalletModel.mock(category: .debt)

        let sut = makeSut(model: model)

        #expect(sut.descriptionText == expectedText)
    }

    @Test func descriptionTextForSavingsCategory() {
        let expectedText = "You can estimate now and change it whenever you want"
        let model = CreateWalletModel.mock(category: .savings)

        let sut = makeSut(model: model)

        #expect(sut.descriptionText == expectedText)
    }

    @Test func descriptionTextForSpendingCategory() {
        let expectedText = "You can estimate now and change it whenever you want"
        let model = CreateWalletModel.mock(category: .spending)

        let sut = makeSut(model: model)

        #expect(sut.descriptionText == expectedText)
    }

    @Test func updatedModelShouldBeUpdatedWithCurrentInputValue() {
        let model = CreateWalletModel.mock(category: .spending, initialBalance: .zero(currency: .USD))

        let sut = makeSut(model: model)
        #expect(sut.inputValue == .zero)
        sut.inputValue = 25.5

        #expect(sut.updatedModel.initialBalance == Money(amount: 25.5, currency: .USD))
    }
}
