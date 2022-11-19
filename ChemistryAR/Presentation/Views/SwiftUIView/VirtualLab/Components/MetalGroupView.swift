//
//  MetalGroupView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 21/10/2022.
//

import SwiftUI
import Foundation

struct MetalGroupView: View {
    let cmsColor: CMSColor
    private var color: Color {
        Color(hex: UInt(cmsColor.hexColor) ?? 0xFFFFFF, alpha: cmsColor.opacity)
    }

    var body: some View {
        ZStack {
            subMetalGroup
            subMetalGroup
                .offset(x: 20, y: 8)
            subMetalGroup
                .offset(x: 15, y: -8)
        }
    }
}

private extension MetalGroupView {
    var subMetalGroup: some View {
        Group {
            Circle()
                .fill(color)
                .squareFrame(6)
                .rotation3DEffect(.degrees(50), axis: (x: 1, y: 0, z: 0))
            Circle()
                .fill(color)
                .squareFrame(6)
                .rotation3DEffect(.degrees(50), axis: (x: 1, y: 1, z: 0))
                .offset(x: 10)
            Circle()
                .fill(color)
                .squareFrame(6)
                .rotation3DEffect(.degrees(40), axis: (x: 0, y: 1, z: 0))
                .offset(x: -10)
            Circle()
                .fill(color)
                .squareFrame(6)
                .rotation3DEffect(.degrees(50), axis: (x: 1, y: 0, z: 1))
                .offset(x: 2, y: 10)
            Circle()
                .fill(color)
                .squareFrame(6)
                .rotation3DEffect(.degrees(50), axis: (x: 1, y: 0, z: 1))
                .offset(x: -8, y: 10)
        }
    }
}
