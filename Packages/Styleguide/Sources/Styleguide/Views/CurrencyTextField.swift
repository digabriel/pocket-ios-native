//
//  CurrencyTextField.swift
//  Styleguide
//
//  Created by Dimas Gabriel on 8/10/24.
//

import UIKit
import SwiftUI

public  class CurrencyUITextField: UITextField {
    @Binding private var value: Decimal
    private lazy var formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        return formatter
    }()

    init(value: Binding<Decimal>) {
        self._value = value
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func willMove(toSuperview newSuperview: UIView?) {
        addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        addTarget(self, action: #selector(resetSelection), for: .allTouchEvents)
        keyboardType = .numberPad
        textAlignment = .center
        sendActions(for: .editingChanged)
    }

    public override func deleteBackward() {
        text = textValue.digits.dropLast().string
        sendActions(for: .editingChanged)
    }

    @objc private func editingChanged() {
        text = currency(from: decimal)
        resetSelection()
        value = decimal
        textColor = value == .zero ? textColor?.withAlphaComponent(0.5) : textColor?.withAlphaComponent(1.0)
    }

    @objc private func resetSelection() {
        selectedTextRange = textRange(from: endOfDocument, to: endOfDocument)
    }

    private var textValue: String {
       return text ?? ""
    }

    private var decimal: Decimal {
      return textValue.decimal / pow(10, formatter.maximumFractionDigits)
    }

    private func currency(from decimal: Decimal) -> String {
        return formatter.string(for: decimal) ?? ""
    }
}

private extension String {
    var decimal: Decimal { Decimal(string: digits) ?? 0 }
}

private extension StringProtocol where Self: RangeReplaceableCollection {
    var digits: Self { filter(\.isWholeNumber) }
}

private extension LosslessStringConvertible {
    var string: String { .init(self) }
}

public struct CurrencyTextField: UIViewRepresentable {
    private let currencyField: CurrencyUITextField

    public init(value: Binding<Decimal>, font: UIFont, color: UIColor) {
        currencyField = CurrencyUITextField(value: value)
        currencyField.font = font
        currencyField.textColor = color
    }

    public func makeUIView(context: Context) -> CurrencyUITextField {
        return currencyField
    }

    public func updateUIView(_ uiView: CurrencyUITextField, context: Context) {}
}
