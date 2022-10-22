//
//  ChatBarView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 17/10/2022.
//

import SwiftUI

struct FloatButtonGroupView: View {
    @Binding var isShowInstrument: Bool
    @Binding var chemicalList: [Chemical]
    @Binding var selectedTab: TabItem

    @State private var addAttachment = false
    @State private var rotateBar = false

    var chatBarHeight: CGFloat = 60

    // MARK:- views
    var body: some View {
        ZStack {
            HStack(spacing: 16) {
                AttachmentButton(needsRotation: $rotateBar, iconName: "plus", iconSize: 24, action: {
                    self.rotateBar.toggle()
                    self.addAttachment.toggle()
                    Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (Timer) in
                        self.addAttachment.toggle()
                    }
                })
                .background(
                    Circle()
                        .fill(Color.white.opacity(0.2))
                        .frame(width: 52, height: 52)
                )
                Color.white.opacity(rotateBar ? 0.2 : 0)
                    .cornerRadius(chatBarHeight / 2)
                    .overlay {
                        HStack(alignment: .center, spacing: 16) {
                            AttachmentButton(needsRotation: .constant(false), iconName: "home.fill") {
                                selectedTab = .home
                            }
                            AttachmentButton(needsRotation: .constant(false), iconName: "tool") {
                                isShowInstrument = true
                                rotateBar = false
                            }
                            AttachmentButton(needsRotation: .constant(false), iconName: "liquid") {
                                isShowInstrument = false
                                rotateBar = false
                                chemicalList = Chemical.liquid
                            }
                            AttachmentButton(needsRotation: .constant(false), iconName: "solid") {
                                isShowInstrument = false
                                rotateBar = false
                                chemicalList = Chemical.solid
                            }
                            AttachmentButton(needsRotation: .constant(false), iconName: "gas") {
                                isShowInstrument = false
                                rotateBar = false
                                chemicalList = Chemical.gas
                            }
                        }
                        .foregroundColor(.white)
                        .rotationEffect(.init(degrees: rotateBar ? 0 : 90), anchor: .zero)
                        .offset(y: rotateBar ? 0 : 72)
                        .animation(Animation.spring(), value: rotateBar)
                    }

            }
        }
        .frame(width: 380, height: self.chatBarHeight)
        .padding()
        .shadow(radius: 8)
        .rotationEffect(self.getBarRotationDegree(), anchor: .leading)
        .animation(
            Animation.interpolatingSpring(
                mass: 2,
                stiffness: 14,
                damping: 10,
                initialVelocity: 5
            )
                .delay(0.1),
            value: rotateBar
        )
    }

    func getBarRotationDegree() -> Angle {
        if rotateBar && addAttachment {
            return .degrees(-3)
        } else if addAttachment {
            return .degrees(3)
        } else {
            return .degrees(0)
        }
    }
}
