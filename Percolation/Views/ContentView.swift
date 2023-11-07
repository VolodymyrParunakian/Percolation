//
//  ContentView.swift
//  Percolation
//
//  Created by Volodymyr Parunakian on 03.03.2020.
//  Copyright © 2020 v.parunakian.com. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var percolation: PercolationCore
    @State var size: Int = 6

    init(size: Int) {
        self.percolation = PercolationCore(with: size)
        self.size = size
    }

    var body: some View {
        VStack {
            Spacer()
            Grid(horizontalSpacing: 1, verticalSpacing: 1) {
                ForEach((1...size), id: \.self) { row in
                    GridRow {
                        ForEach((1...size), id: \.self) { col in
                            if percolation.isFull(row: row, col: col) {
                                SquareView(color: .blue)
                            } else if percolation.isOpen(row: row, col: col) {
                                SquareView(color: .white)
                            } else {
                                SquareView(color: .black)
                            }
                        }
                    }
                }
            }
            Spacer()
            Text("azaza")
            Spacer()
        }
        .padding()
    }

//    // draw n-by-n percolation system
//    public static void draw(Percolation perc, int n) {
//        StdDraw.clear();
//        StdDraw.setPenColor(StdDraw.BLACK);
//        StdDraw.setXscale(-0.05 * n, 1.05 * n);
//        StdDraw.setYscale(-0.05 * n, 1.05 * n);   // leave a border to write text
//        StdDraw.filledSquare(n / 2.0, n / 2.0, n / 2.0);
//
//        // draw n-by-n grid
//        int opened = 0;
//        for (int row = 1; row <= n; row++) {
//            for (int col = 1; col <= n; col++) {
//                if (perc.isFull(row, col)) {
//                    StdDraw.setPenColor(StdDraw.BOOK_LIGHT_BLUE);
//                    opened++;
//                }
//                else if (perc.isOpen(row, col)) {
//                    StdDraw.setPenColor(StdDraw.WHITE);
//                    opened++;
//                }
//                else
//                    StdDraw.setPenColor(StdDraw.BLACK);
//                StdDraw.filledSquare(col - 0.5, n - row + 0.5, 0.45);
//            }
//        }
//
//        // write status text
//        StdDraw.setFont(new Font("SansSerif", Font.PLAIN, 12));
//        StdDraw.setPenColor(StdDraw.BLACK);
//        StdDraw.text(0.25 * n, -0.025 * n, opened + " open sites");
//        if (perc.percolates()) StdDraw.text(0.75 * n, -0.025 * n, "percolates");
//        else StdDraw.text(0.75 * n, -0.025 * n, "does not percolate");
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(size: 8)
    }
}
