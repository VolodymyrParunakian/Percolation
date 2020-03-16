//
//  WeightedQuickUnionTest.swift
//  PercolationTests
//
//  Created by Volodymyr Parunakian on 07.03.2020.
//  Copyright © 2020 v.parunakian.com. All rights reserved.
//

import XCTest
@testable import Percolation

class WeightedQuickUnionTests: XCTestCase {
    private let unionUF = WeightedQuickUnionUF(with: 20)

    func testMethods() {
        // check init values
        XCTAssertEqual(unionUF.numberOfSets(), 20)
        XCTAssertEqual(unionUF.find(3), 3)
        // try union
        unionUF.union(p: 3, q: 4)
        XCTAssertEqual(unionUF.numberOfSets(), 19)
        XCTAssertTrue(unionUF.connected(p: 3, q: 4))
        // try multiple unions
        unionUF.union(p: 6, q: 15)
        unionUF.union(p: 10, q: 19)
        unionUF.union(p: 19, q: 15)
        XCTAssertEqual(unionUF.numberOfSets(), 16)
        XCTAssertTrue(unionUF.connected(p: 10, q: 6))
    }
}
