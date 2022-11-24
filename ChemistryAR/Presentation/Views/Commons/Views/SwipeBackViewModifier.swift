//
//  SwipeBackViewModifier.swift
//  ChemistryAR
//
//  Created by NhatMinh on 23/11/2022.
//

import SwiftUI

struct SwipeBackViewModifier: ViewModifier {
    @Binding var isPresented: Bool
    let maxTranslation: CGFloat

    func body(content: Content) -> some View {
        content
            .gesture(
                DragGesture()
                    .onEnded { value in
                        withAnimation {
                            let translation = value.translation.width
                            if translation > maxTranslation {
                                isPresented = false
                            }
                        }
                    }
            )
    }
}
