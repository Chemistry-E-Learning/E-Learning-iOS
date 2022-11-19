//
//  DropGroupView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 21/10/2022.
//

import Foundation
import SwiftUI

struct DropGroupView: View {
    @Binding var isAnimating: Bool
    @Binding var isLiquid: Bool

    let cmsColor: CMSColor
    let initialOffSet: CGSize
    private let animationOffset = 0.1
    private var chemicalColor: Color { 
        return Color(hex: UInt(Float(cmsColor.hexColor) ?? 0) ?? 0xFFFFFF, alpha: cmsColor.opacity)
    }
    private var solidProperties: [(Int, CGSize, Double)] {
        [
            (1, CGSize(width: initialOffSet.width - 15, height: -150), 0),
            (2, CGSize(width: initialOffSet.width - 10, height: -80), 0.05),
            (3, CGSize(width: initialOffSet.width, height: -100), 0.15),
            (4, CGSize(width: initialOffSet.width , height: -180), 0.15),
            (5, CGSize(width: initialOffSet.width - 20, height: -110), 0.2),
            (6, CGSize(width: initialOffSet.width, height: -120), 0.25),
            (7, CGSize(width: initialOffSet.width - 15, height: -130), 0.35),
            (8, CGSize(width: initialOffSet.width - 10, height: -160), 0.4),
            (9, CGSize(width: initialOffSet.width, height: -145), 0.45),
        ]
    }

    private var liquidProperties: [(Int, CGSize, Double)] {
        [
            (1, CGSize(width: initialOffSet.width - 2, height: -150), 0),
            (2, CGSize(width: initialOffSet.width - 1, height: -150), 0.05),
            (3, CGSize(width: initialOffSet.width - 1, height: -150), 0.15),
            (4, CGSize(width: initialOffSet.width - 1, height: -150), 0.15),
            (5, CGSize(width: initialOffSet.width - 1, height: -150), 0.2),
            (6, CGSize(width: initialOffSet.width, height: -150), 0.25),
            (7, CGSize(width: initialOffSet.width - 3, height: -150), 0.35),
        ]
    }

    var body: some View {
        ZStack {
            ForEach(isLiquid ? liquidProperties : solidProperties, id: \.0) { item in
                Pill(
                    isLiquid: $isLiquid,
                    animationOffset: item.1,
                    animationDelay: animationOffset + item.2,
                    isAnimating: $isAnimating,
                    chemicalColor: chemicalColor
                )
            }
        }
    }
}

struct Pill: View {
    @Binding var isLiquid: Bool

    let animationOffset: CGSize
    let animationDuration: TimeInterval = 0.075
    let animationDelay: TimeInterval

    @Binding var isAnimating: Bool
    let chemicalColor: Color

    var body: some View {
        DropPin()
            .foregroundColor(chemicalColor)
            .frame(width: 4, height: isLiquid ? 80 : 8)
            .offset(isAnimating ? animationOffset : CGSize.zero)
            .animation(
                Animation.spring()
                    .speed(1)
                    .delay(animationDelay)
                ,value: isAnimating
            )
            .opacity(isAnimating ? 1 : 0)
    }
}
