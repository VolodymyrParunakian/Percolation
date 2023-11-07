//
//  SquareView.swift
//  Percolation
//
//  Created by Volodymyr Parunakian on 02.06.2020.
//  Copyright © 2020 v.parunakian.com. All rights reserved.
//

import SwiftUI

enum SquareState {
    case closed, opened, full
}

struct SquareView: View {
    @State var color = Color.black

    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .foregroundColor(color)
    }
}

struct SquareView_Previews: PreviewProvider {
    static var previews: some View {
        SquareView(color: .black)
    }
}
