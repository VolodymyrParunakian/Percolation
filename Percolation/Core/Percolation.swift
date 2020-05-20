//
//  Percolation.swift
//  Percolation
//
//  Created by Volodymyr Parunakian on 14.03.2020.
//  Copyright © 2020 v.parunakian.com. All rights reserved.
//
//  swiftlint:disable identifier_name

import UIKit

internal enum PercolationError: Error {
    case illegalArgument(String)
}

final internal class Percolation {
    private struct SiteStatus: OptionSet {
        let rawValue: UInt8

        static let blocked = SiteStatus([])
        static let open = SiteStatus(rawValue: 1 << 0)
        static let connectedToTop = SiteStatus(rawValue: 1 << 1)
        static let connectedToBottom = SiteStatus(rawValue: 1 << 2)

        var isOpen: Bool {
            return self.contains(.open)
        }

        var isFull: Bool {
            return self.contains([.open, .connectedToTop])
        }

        var percolates: Bool {
            return self.contains([.open, .connectedToBottom, .connectedToTop])
        }
    }

    private let n: Int
    private let unionUF: WeightedQuickUnionUF
    // contain statuses of sites in a one-dimensional array
    private var statuses: [SiteStatus]
    private var openCounter = 0
    // percolation flag
    private var percolatesFlag = false

    init?(with n: Int) {
        if n <= 0 {
            print("\(n) must be larger than 0")
            return nil
        }

        self.n = n
        // create union-find structure
        self.unionUF = WeightedQuickUnionUF(with: n * n)
        // populate sites as blocked initially
        self.statuses = [SiteStatus](repeating: .blocked, count: n * n)
    }

    private func validateIndices(row: Int, col: Int) throws {
        if row <= 0 || row > n {
            throw PercolationError.illegalArgument("index \(row) must be between 1 and \(n)")
        }
        if col <= 0 || col > n {
            throw PercolationError.illegalArgument("index \(col) must be between 1 and \(n)")
        }
    }

    private func index(for row: Int, col: Int) -> Int {
        return row.aIndex * n + col.aIndex
    }

    private func openAndCheckNeighborsFor(row: Int, col: Int) {
        openCounter += 1
        var combinedStatus: SiteStatus = .open
        let currentIndex = index(for: row, col: col)

        func checkNeighboor(neighboorIndex: Int, currentIndex: Int) {
            let rootIndex = unionUF.find(neighboorIndex)
            let status = statuses[rootIndex]
            if status.isOpen {
                combinedStatus.insert(status)
                unionUF.union(p: neighboorIndex, q: currentIndex)
            }
        }

        // If first row, the site will be full immediately
        if row == 1 {
            combinedStatus.insert(.connectedToTop)
        } else {
            let neighboorIndex = index(for: row - 1, col: col)
            checkNeighboor(neighboorIndex: neighboorIndex, currentIndex: currentIndex)
        }
        // if last row, the site is open and connected to bottom
        if row == n {
            combinedStatus.insert(.connectedToBottom)
        } else {
            let neighboorIndex = index(for: row + 1, col: col)
            checkNeighboor(neighboorIndex: neighboorIndex, currentIndex: currentIndex)
        }
        // check horizontally placed sites
        if col > 1 {
            let neighboorIndex = index(for: row, col: col - 1)
            checkNeighboor(neighboorIndex: neighboorIndex, currentIndex: currentIndex)
        }
        if col < n {
            let neighboorIndex = index(for: row, col: col + 1)
            checkNeighboor(neighboorIndex: neighboorIndex, currentIndex: currentIndex)
        }

        statuses[currentIndex] = combinedStatus
        let rootIndex = unionUF.find(currentIndex)
        statuses[rootIndex] = combinedStatus
        if statuses[rootIndex].percolates {
            percolatesFlag = true
        }
    }

    func open(row: Int, col: Int) {
        do {
            try validateIndices(row: row, col: col)
        } catch {
            print(error.localizedDescription)
        }

        if isOpen(row: row, col: col) {
            return
        }
        openAndCheckNeighborsFor(row: row, col: col)
    }

    func isOpen(row: Int, col: Int) -> Bool {
        do {
            try validateIndices(row: row, col: col)
        } catch {
            print(error.localizedDescription)
            return false
        }

        return statuses[index(for: row, col: col)].isOpen
    }

    func isFull(row: Int, col: Int) -> Bool {
        do {
            try validateIndices(row: row, col: col)
        } catch {
            print(error.localizedDescription)
            return false
        }

        let rootIndex = unionUF.find(index(for: row, col: col))
        return statuses[rootIndex].isFull
    }

    func numberOfOpenSites() -> Int {
        return openCounter
    }

    func percolates() -> Bool {
        return percolatesFlag
    }
}

// extension for more readability
// helps calculate index for a one-dimensional array
private extension Int {
    var aIndex: Int {
        return self - 1
    }
}
