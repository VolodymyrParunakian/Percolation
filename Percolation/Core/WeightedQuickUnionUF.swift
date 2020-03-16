//
//  WeightedQuickUnionUF.swift
//  Percolation
//
//  Weighted quick-union (without path compression).
//
//  Created by Volodymyr Parunakian on 04.03.2020.
//
//  Original Java implementation by Robert Sedgewick and Kevin Wayne.
//  For additional documentation, see https://algs4.cs.princeton.edu/15uf of
//  Algorithms, 4th Edition by Robert Sedgewick and Kevin Wayne.
//  Copyright 2002-2018, Robert Sedgewick and Kevin Wayne.
//
//  swiftlint:disable identifier_name

enum WeightedQuickUnionUFError: Error {
    case indexIsOutOfBounds(_ n: Int)
}

final class WeightedQuickUnionUF {
    private var parent: [Int] // parent[index] = parent of index
    private var size: [Int]   // size[index] = number of elements in subtree rooted at index
    private var count: Int    // number of components

    /**
     Initializes an empty union-find data structure with
     `n` elements `0` through `n - 1`. Initially, each elements is in its own set.
     - Parameter n: the number of elements`
     */
    init(with n: Int) {
        self.count = n
        self.parent = [Int](0..<n)
        self.size = Array(repeating: 1, count: n)
    }
    /**
     - Returns: the number of sets (between `1` and `n`)
     */
    func numberOfSets() -> Int {
        return count
    }
    /**
     Returns the canonical element of the set containing element `p`.
    
     - Parameter p: an element
     - Returns: the canonical element of the set containing `p`
     */
    func find(_ p: Int) -> Int {
        do {
            try validate(p)
        } catch WeightedQuickUnionUFError.indexIsOutOfBounds(let limit) {
            print("index \(p) must be between 0 and \(limit)")
            return -1
        } catch {
            print("Unexpected error: \(error).")
            return -1
        }
        var p = p
        while p != parent[p] {
            p = parent[p]
        }
        return p
    }
    /**
     Returns true if the two elements are in the same set.
     
     - Parameter  p: one element
     - Parameter q: the other element
     - Returns: `true` if `p` and `q` are in the same set
              and `false` otherwise
     */
    func connected(p: Int, q: Int) -> Bool {
        return find(p) == find(q)
    }
    /**
    Validate that p is a valid index
     */
    private func validate(_ p: Int) throws {
        let n = parent.count
        guard p >= 0 && p < n else {
            throw WeightedQuickUnionUFError.indexIsOutOfBounds(n - 1)
        }
    }
    /**
     Merges the set containing element `p` with the
     the set containing element `q`.
     
     - Parameter p: one element
     - Param q: the other element
     */
    func union(p: Int, q: Int) {
        let rootP = find(p)
        let rootQ = find(q)
        if rootP == rootQ {
            return
        }
        // make smaller root point to larger one
        if size[rootP] < size[rootQ] {
            parent[rootP] = rootQ
            size[rootQ] += size[rootP]
        } else {
            parent[rootQ] = rootP
            size[rootP] += size[rootQ]
        }
        count -= 1
    }
}
