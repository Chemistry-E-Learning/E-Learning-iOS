//
//  WaterFlowAnimation.swift
//  ChemistryAR
//
//  Created by NhatMinh on 20/10/2022.
//

import SwiftUI

struct WaterFlowAnimation: View {
    @Binding var isAnimating: Bool
    @State private var fillCapsule = false
    @State private var time: CGFloat = 0.5

    let chemicalColor: Color
    let size: CGSize
    private let trackerRotation = 1.5
    private let animationDuration = 1.0

    var body: some View {
        ZStack {
            WaveFillShape(curve: time, curveHeight: 6, curveLength: 1.5)
                .fill(chemicalColor.opacity(0.9))
                .offset(y: fillCapsule ? 0 : 180)
            WaveFillShape(curve: time * 2.5, curveHeight: 8, curveLength: 1.5)
                .fill(chemicalColor.opacity(0.8))
                .offset(y: fillCapsule ? 0 : 180)
        }
        .frame(width: size.width, height: size.height)
        .onChange(of: isAnimating) { newValue in
            if newValue {
                animateLoader()
            }
        }
    }
}

// MARK: - Animation Functions
private extension WaterFlowAnimation {
    func animateLoader() {
        withAnimation(
            Animation.interactiveSpring(
                response: animationDuration * trackerRotation,
                dampingFraction: 1,
                blendDuration: 1
            )
        ) {
            fillCapsule = true
        }
        Timer.scheduledTimer(
            withTimeInterval: (animationDuration * trackerRotation) - 0.25, repeats: false
        ) { _ in
            Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { curveTimer in
                if fillCapsule && isAnimating {
                    time += 0.01
                } else {
                    curveTimer.invalidate()
                }
            }
        }
    }
}
struct WaterFlowAnimation_Previews: PreviewProvider {
    static var previews: some View {
        WaterFlowAnimation(
            isAnimating: .constant(true),
            chemicalColor: .yellow.opacity(0.6),
            size: CGSize(width: 120, height: 120)
        )
    }
}
