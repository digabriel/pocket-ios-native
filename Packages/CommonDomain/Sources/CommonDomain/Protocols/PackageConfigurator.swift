//
//  Package.swift
//  
//
//  Created by Dimas Gabriel on 7/4/24.
//

import SwiftData

public protocol PackageConfigurator {
    init(modelContainer: ModelContainer)
    func setupData() async
}
