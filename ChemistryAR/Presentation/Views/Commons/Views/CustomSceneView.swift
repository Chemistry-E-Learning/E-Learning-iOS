//
//  CustomSceneView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 13/10/2022.
//

import SwiftUI
import SceneKit

struct CustomSceneView: UIViewRepresentable {
    @Binding var model: Element3DModel

    func makeUIView(context: Context) -> SCNView {
        let view = SCNView()
        view.allowsCameraControl = true
        view.autoenablesDefaultLighting = true
        view.scalesLargeContentImage = true
        view.antialiasingMode = .multisampling2X
        let scene: SCNScene? = .init(named: "art.scnassets/\(model.name).scn")
        view.scene = scene
        view.backgroundColor = .clear
        return view
    }

    func updateUIView(_ uiView: SCNView, context: Context) {
        let scene: SCNScene? = .init(named: "art.scnassets/\(model.name).scn")
        print("MinhNN44 - \(model.name) - \(scene)")
        scene?.rootNode.scale = model.scale
        scene?.rootNode.eulerAngles.x = model.angle
        scene?.rootNode.position.y = model.position.y
        scene?.rootNode.position.x = model.position.x
        uiView.scene = scene
    }
}
