//
//  Documents+XCUIElementQuery.swift
//  proNotesUITests
//
//  Created by Timur Khasanov on 10/31/18.
//  Copyright © 2018 leonardthomas. All rights reserved.
//

import XCTest

extension XCUIElementQuery {
    var countVisibleElements: UInt {
        return UInt(allElementsBoundByIndex.filter { $0.isHittable }.count)
    }
}
