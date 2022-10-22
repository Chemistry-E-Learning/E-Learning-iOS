//
//  WaveFillShape.swift
//  ChemistryAR
//
//  Created by NhatMinh on 20/10/2022.
//

import SwiftUI

struct WaveFillShape: Shape {
    // MARK:- variables
    var curve: CGFloat
    let curveHeight: CGFloat
    let curveLength: CGFloat

    // MARK:- functions
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.width, y: rect.height * 2))
        path.addLine(to: CGPoint(x: 0, y: rect.height * 2))

        for i in stride(from: 0, to: CGFloat(rect.width), by: 1) {
            path.addLine(to: CGPoint(x: i, y: sin(((i / rect.height) + curve) * curveLength * .pi) * curveHeight + rect.midY))
        }
        path.addLine(to: CGPoint(x: rect.width, y:  rect.height * 2))
        return path
    }
}
