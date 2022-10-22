//
//  FillShape.swift
//  ChemistryAR
//
//  Created by NhatMinh on 20/10/2022.
//

import SwiftUI

struct FillShapes: View {
    let xOffset: CGFloat
    let yOffset: CGFloat
    let capsuleSpacing: CGFloat

    var body: some View {
        ZStack {
            Circle()
                .frame(width: 20, height: 20)
                .foregroundColor(Color.white.opacity(0.55))
                .shadow(color: .white, radius: 10, x: 1, y: 1)
                .offset(x: xOffset, y: yOffset)
            Capsule(style: .continuous)
                .frame(width: 20, height: 40)
                .foregroundColor(Color.white.opacity(0.55))
                .shadow(color: .white, radius: 10, x: 1, y: 1)
                .offset(x: xOffset, y: yOffset + capsuleSpacing)
        }
    }
}
