//
//  LottieAnimationView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 06/12/2022.
//

import SwiftUI
import Lottie

struct LottieAnimationView: UIViewRepresentable {
    let fileName: String
    func makeUIView(context: Context) -> AnimationView {
        let view = AnimationView(name: "\(fileName).json", bundle: Bundle.main)
        view.play()
        return view
    }

    func updateUIView(_ uiView: AnimationView, context: Context) {
    }
}
