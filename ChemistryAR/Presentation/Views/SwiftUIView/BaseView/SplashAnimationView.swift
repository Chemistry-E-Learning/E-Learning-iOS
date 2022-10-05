//
//  SplashAnimationView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 04/10/2022.
//

import SwiftUI
import Lottie

struct SplashAnimationView: UIViewRepresentable {
    func makeUIView(context: Context) -> AnimationView {
        let view = AnimationView(name: "splash.json", bundle: Bundle.main)
        view.play()
        return view
    }

    func updateUIView(_ uiView: AnimationView, context: Context) {
    }
}
