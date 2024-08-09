//
//  Currency.swift
//  CommonDomain
//
//  Created by Dimas Gabriel on 8/8/24.
//

public enum Currency: Sendable {
    case USD, BRL

    public var code: String {
        switch self {
        case .USD:
            return "USD"
        case .BRL:
            return "BRL"
        }
    }
}

public extension Currency {
    static func from(code: String) throws -> Currency {
        switch code {
        case "USD":
            return .USD
        case "BRL":
            return .BRL
        default:
            throw CurrencyError.invalidCode
        }
    }
}

public enum CurrencyError: Error {
    case invalidCode
}
