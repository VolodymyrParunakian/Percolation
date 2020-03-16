//
//  PercolationTests.swift
//  PercolationTests
//
//  Created by Volodymyr Parunakian on 03.03.2020.
//  Copyright © 2020 v.parunakian.com. All rights reserved.
//

import XCTest
@testable import Percolation

class PercolationTests: XCTestCase {

    func testZeroInit() {
        let percolation = Percolation(with: 0)
        XCTAssertNil(percolation)
    }

    func testOpen() {
        let oPercolation = Percolation(with: 3)
        guard let percolation = oPercolation else {
            XCTFail("Unexpected nil object")
            return
        }
        percolation.open(row: 3, col: 3)
        percolation.open(row: 1, col: 2)
        XCTAssertTrue(percolation.isOpen(row: 3, col: 3))
        XCTAssertTrue(percolation.isOpen(row: 1, col: 2))
        XCTAssertFalse(percolation.isOpen(row: 1, col: 1))
    }

    func testFull() {
        let oPercolation = Percolation(with: 3)
        guard let percolation = oPercolation else {
            XCTFail("Unexpected nil object")
            return
        }

        percolation.open(row: 1, col: 1)
        percolation.open(row: 3, col: 3)

        XCTAssertTrue(percolation.isFull(row: 1, col: 1))
        XCTAssertFalse(percolation.isFull(row: 3, col: 3))
    }

    func testPercolation() {
        let oPercolation = Percolation(with: 3)
        guard let percolation = oPercolation else {
            XCTFail("Unexpected nil object")
            return
        }

        XCTAssertFalse(percolation.percolates())
        percolation.open(row: 1, col: 1)
        XCTAssertFalse(percolation.percolates())
        percolation.open(row: 3, col: 1)
        XCTAssertFalse(percolation.percolates())
        percolation.open(row: 2, col: 1)
        XCTAssertTrue(percolation.percolates())
    }

    func testBackwashing() {
        let oPercolation = Percolation(with: 3)
        guard let percolation = oPercolation else {
            XCTFail("Unexpected nil object")
            return
        }

        percolation.open(row: 1, col: 1)
        percolation.open(row: 2, col: 1)
        percolation.open(row: 3, col: 1)
        percolation.open(row: 3, col: 3)

        XCTAssertTrue(percolation.isFull(row: 1, col: 1))
        XCTAssertTrue(percolation.isFull(row: 2, col: 1))
        XCTAssertTrue(percolation.isFull(row: 3, col: 1))
        XCTAssertFalse(percolation.isFull(row: 3, col: 3))
    }
}
