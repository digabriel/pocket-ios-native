//
//  CreateWalletNavigationStack+ViewModel.swift
//  
//
//  Created by Dimas Gabriel on 7/8/24.
//

import Foundation
import SwiftUI

extension CreateWalletNavigationStack {
    @MainActor @Observable final class ViewModel {
        private let dependency: Dependency

        private(set) var sections: [Section] = []

        var currentSectionIndex = 0 {
            didSet { activeSection = sections[currentSectionIndex] }
        }
        private(set) var activeSection: Section?

        init(dependency: Dependency) {
            self.dependency = dependency
        }

        func refresh() async {
            do {
                let walletCategories = try await dependency.getWalletCategoriesUseCase.execute(input: ())
                sections = walletCategories.map { .init(title: $0.name, tipText: $0.tipText, items: $0.items) }
                activeSection = sections[currentSectionIndex]
            } catch {
                sections = []
            }
        }

        func selectPreviousSection() {
            if currentSectionIndex > 0 {
                currentSectionIndex -= 1
            }
        }

        func selectNextSection() {
            if currentSectionIndex < sections.count-1 {
                currentSectionIndex += 1
            }
        }
    }
}

extension CreateWalletNavigationStack {
    struct Section {
        let title: String
        let tipText: String?
        let items: [SectionItem]
    }

    struct SectionItem: Identifiable {
        let title: String
        let description: String
        let iconName: String
        let iconBackgroundColor: Color

        var id: String { title + description }
    }

    struct Dependency: Sendable {
        let getWalletCategoriesUseCase: any GetWalletCategoriesProtocol
    }
}

private extension WalletCategory {
    var tipText: String? {
        switch self {
        case .spending:
            return nil
        case .savings:
            return String(localized: """
People who set their savings goal save faster and up to $550 more a year than people who don’t.
""")
        case .debt:
            return String(localized: """
Debt wallets reduces your net worth. Expenses added from debt wallet deminishes the remaining balance of the wallet.
""")
        }
    }
    var items: [CreateWalletNavigationStack.SectionItem] {
        switch self {
        case .spending:
            return [
                .init(
                    title: String(localized: "Spending"),
                    description: String(localized: "The wallet for your daily spendings - i.e. your salary account."),
                    iconName: "wallet",
                    iconBackgroundColor: Color.regular.lightBlue
                ),
                .init(
                    title: String(localized: "Credit"),
                    description: String(localized: "For you credit card or other accounts with credit limit."),
                    iconName: "creditCard",
                    iconBackgroundColor: Color.regular.pastelRed
                ),
                .init(
                    title: String(localized: "Cash"),
                    description: String(localized: "For money and transactions you make with cash."),
                    iconName: "cash",
                    iconBackgroundColor: Color.regular.purple
                ),
                .init(
                    title: String(localized: "Custom"),
                    description: String(localized: "Specify yourself."),
                    iconName: "wallet",
                    iconBackgroundColor: Color.regular.lightGray
                )
            ]
        case .savings:
            return [
                .init(
                    title: String(localized: "Savings"),
                    description: String(localized: "Your default savings wallets."),
                    iconName: "moneyBag",
                    iconBackgroundColor: Color.regular.blueGreen
                ),
                .init(
                    title: String(localized: "Rainy Day Fund"),
                    description: String(localized: "Reserved money for special need."),
                    iconName: "heart",
                    iconBackgroundColor: Color.regular.pink
                ),
                .init(
                    title: String(localized: "Trip"),
                    description: String(localized: "Savings for your trip or your vacation."),
                    iconName: "star",
                    iconBackgroundColor: Color.regular.darkGreen
                ),
                .init(
                    title: String(localized: "House"),
                    description: String(localized: "Save up to buy a house or apartment."),
                    iconName: "moneyHouse",
                    iconBackgroundColor: Color.regular.orange
                ),
                .init(
                    title: String(localized: "Custom"),
                    description: String(localized: "Specify yourself."),
                    iconName: "wallet",
                    iconBackgroundColor: Color.regular.lightGray
                )
            ]
        case .debt:
            return [
                .init(
                    title: String(localized: "Loan"),
                    description: String(localized: "Your bank load, mortage or short term debt."),
                    iconName: "moneyHouse",
                    iconBackgroundColor: Color.regular.blue
                ),
                .init(
                    title: String(localized: "Personal Debt"),
                    description: String(localized: "Money that you owe someone else."),
                    iconName: "people",
                    iconBackgroundColor: Color.regular.red
                ),
                .init(
                    title: String(localized: "Car Loan"),
                    description: String(localized: "Track your payments for you car loan."),
                    iconName: "car",
                    iconBackgroundColor: Color.regular.darkGray
                ),
                .init(
                    title: String(localized: "Custom"),
                    description: String(localized: "Specify yourself."),
                    iconName: "wallet",
                    iconBackgroundColor: Color.regular.lightGray
                )
            ]

        }
    }
}
