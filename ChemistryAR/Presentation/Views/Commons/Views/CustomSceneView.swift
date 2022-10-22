//
//  CustomSceneView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 13/10/2022.
//

import SwiftUI
import SceneKit

struct CustomSceneView: UIViewRepresentable {
    let scene: SCNScene?

    func makeUIView(context: Context) -> SCNView {
        let view = SCNView()
        view.allowsCameraControl = true
        view.autoenablesDefaultLighting = true
        view.scalesLargeContentImage = true
        view.antialiasingMode = .multisampling2X
        view.scene = scene
        view.backgroundColor = .clear
        return view
    }

    func updateUIView(_ uiView: SCNView, context: Context) {
    }
}
