//
//  SwiftDatatWalletCategory.swift
//  
//
//  Created by Dimas Gabriel on 7/6/24.
//

import SwiftData

@Model public class SwiftDataWalletCategory {
    let identifier: Int

    init(identifier: Int) {
        self.identifier = identifier
    }
}

extension SwiftDataWalletCategory {
    func toDomain() throws -> WalletCategory {
        guard let domainModel = WalletCategory(rawValue: identifier) else {
            throw WalletCategoryError.invalidRawValue
        }
        return domainModel
    }

    convenience init(domainModel: WalletCategory) {
        self.init(identifier: domainModel.rawValue)
    }
}

