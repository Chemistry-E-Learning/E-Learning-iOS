//
//  PeriodicTableAR.swift
//  ChemistryAR
//
//  Created by NhatMinh on 21/11/2022.
//

import SwiftUI
import Foundation
import SceneKit
import ARKit

struct VirtualElementView: View {
    @Binding var isShowARCamera: Bool
    @Binding var models: [Element3DModel]
    @State private var sceneView = ARSCNView(
        frame: CGRect(
            x: 0,
            y: 0,
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height * 0.38
        )
    )
    let overview: OverviewModel
    let nature: NatureModel
    let atomParameter: AtomParameter

    var body: some View {
        ZStack(alignment: .topTrailing) {
            PeriodicTableARView(
                models: .constant(Element3DModel.dummyData),
                sceneView: $sceneView,
                overview: overview,
                nature: nature,
                atomParameter: atomParameter
            )
            HStack(spacing: 20) {
                Spacer()
                Button {
                    sceneView.scene.rootNode.childNodes.first { node in
                        node.childNodes.count > 0
                    }?.childNodes.forEach({ node in
                        node.removeFromParentNode()
                    })
                    isShowARCamera = false
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                        .padding(8)
                        .background {
                            Color.gray.opacity(0.6)
                                .cornerRadius(4)
                        }
                        .scaleEffect(1.6)
                }
            }
            .padding(.top, getSafeArea(edge: .top) - 4)
            .padding(.horizontal, 20)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct PeriodicTableARView: UIViewRepresentable {
    @Binding var models: [Element3DModel]
    @Binding var sceneView: ARSCNView
    @State private var index = 0
    let overview: OverviewModel
    let nature: NatureModel
    let atomParameter: AtomParameter
    var geometryNode = SCNNode()

    func makeCoordinator() -> PeriodicTableCoordinator {
        PeriodicTableCoordinator()
    }

    func makeUIView(context: Context) -> ARSCNView {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal

        sceneView.delegate = context.coordinator
        sceneView.showsStatistics = true
        sceneView.session.run(configuration)

        geometryNode.position.z = Float(-0.2)

        let plane = SCNPlane(width: 0.05, height: 0.05)
        let planeNode = SCNNode(geometry: plane)
        plane.firstMaterial?.diffuse.contents = UIColor.clear
        add3DModels(for: planeNode)

        let overviewPlane = SCNPlane(width: 0.1, height: 0.1)
        let overviewNode = SCNNode(geometry: overviewPlane)

        addInformationView(for: overviewNode)

        let buttonGroup = SCNPlane(width: 0.05, height: 0.05)
        let buttonGroupNode = SCNNode(geometry: buttonGroup)
        buttonGroupNode.position.y = Float(-0.04)
        ControlButtonGroup(index: $index, dataCount: models.count)
            .createHostingController(for: buttonGroupNode, width: 100, height: 40) // 200 200

        geometryNode.addChildNode(planeNode)
                geometryNode.addChildNode(overviewNode)
        // geometryNode.addChildNode(buttonGroupNode)
        sceneView.scene.rootNode.addChildNode(geometryNode)

        return sceneView

    }

    func updateUIView(_ uiView: ARSCNView, context: Context) {
        updateMainNode()
    }

    func add3DModels(for node: SCNNode) {
        models.forEach { item in
            addModelEntityInNode(
                modelName: item.name,
                scale: item.scale,
                angle: item.angle,
                for: node,
                position: item.position
            )
        }
    }

    func addInformationView(for node: SCNNode) {
        node.geometry?.firstMaterial?.diffuse.contents = UIColor(white: 1, alpha: 1)
        node.position.x = Float(0.08)
        node.position.y = Float(-0.02)
    }

    func addModelEntityInNode(
        modelName: String,
        scale: SCNVector3,
        angle: Float,
        for node: SCNNode,
        position: SCNVector3 = SCNVector3(x: 0, y: 0, z: 0)
    ) {
        if let elementScene = SCNScene(named: "art.scnassets/\(modelName).scn") {
            if let elementNode = elementScene.rootNode.childNodes.first {
                elementNode.position = position
                elementNode.eulerAngles.x = angle
                elementNode.scale = scale
                node.addChildNode(elementNode)
            }
        }
    }

    func updateMainNode() {
        guard let modelNode = geometryNode.childNodes.first else { return }
        modelNode.childNodes.enumerated().forEach { indicator, node in
            node.opacity = indicator == index ? 1 : 0
        }
    }
}

class PeriodicTableCoordinator: NSObject, ARSCNViewDelegate {
    // MARK: - Anchor Method
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
        return node
    }

    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
    }

    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
    }

    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
    }
}
