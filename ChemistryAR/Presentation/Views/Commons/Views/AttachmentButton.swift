//
//  AttachmentButton.swift
//  ChemistryAR
//
//  Created by NhatMinh on 17/10/2022.
//

import SwiftUI

struct AttachmentButton: View {
    @Binding var needsRotation: Bool
    @State private var buttonPressAnimation = false

    var iconName: String
    var iconSize: CGFloat = 20
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Image("\(iconName)")
                .renderingMode(.template)
                .resizable()
                .scaledToFill()
                .squareFrame(iconSize)
                .foregroundColor(.white)
                .padding()
                .background(Color.blue.opacity(0.5))
                .cornerRadius(32)
                .rotationEffect(.init(degrees: needsRotation ? 137 : 0))
                .animation(Animation.easeIn(duration: 0.25).speed(1.5), value: needsRotation)
                .overlay(
                    Circle()
                        .opacity(buttonPressAnimation ? 0.1: 0)
                        .scaleEffect(buttonPressAnimation ? 0.95 : 0.5)
                        .animation(.easeIn(duration: buttonPressAnimation ? 0.25 : 0), value: buttonPressAnimation)
                )
        }
        .frame(width: 44, height: 44)
    }
}
