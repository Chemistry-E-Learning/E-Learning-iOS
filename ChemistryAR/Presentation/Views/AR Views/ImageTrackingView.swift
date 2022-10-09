//
//  ImageTrackingView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 21/09/2022.
//

import SwiftUI
import Foundation
import SceneKit
import SceneKit.ModelIO
import ARKit

struct ImageTrackingView: View {
    var body: some View {
        ZStack {
            ImageTrackingARView()
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ImageTrackingARView: UIViewRepresentable {
    var sceneView = ARSCNView(frame: .zero)

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    func makeUIView(context: Context) -> ARSCNView {
        guard let referenceImages = ARReferenceImage.referenceImages(
            inGroupNamed: AppConstant.ChemistryElementResource,
            bundle: nil)
        else {
            fatalError(AppConstant.NoAsset)
        }

        let configuration = ARWorldTrackingConfiguration()
        configuration.isAutoFocusEnabled = true
        configuration.detectionImages = referenceImages
        configuration.maximumNumberOfTrackedImages = AppConstant.maximumImageTracking

        sceneView.delegate = context.coordinator
        sceneView.showsStatistics = true
        sceneView.autoenablesDefaultLighting = true
        sceneView.automaticallyUpdatesLighting = true
        sceneView.session.run(configuration)
        return sceneView
    }

    func updateUIView(_ uiView: ARSCNView, context: Context) {
    }

    class Coordinator: NSObject, ARSCNViewDelegate {
        var parent: ImageTrackingARView

        init(parent: ImageTrackingARView) {
            self.parent = parent
        }

        // MARK: - Anchor Method
        func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
            let node = SCNNode()
            if let imageAnchor = anchor as? ARImageAnchor, let imageName = imageAnchor.name {
                let physicSize = imageAnchor.referenceImage.physicalSize
                let plane = SCNPlane(width: physicSize.width, height: physicSize.height)
                let planeNode = SCNNode(geometry: plane)

                let inforPlane = SCNPlane(width: physicSize.width * 1.6, height: physicSize.height * 2.5)
                let inforNode = SCNNode(geometry: inforPlane)
                let initialXPosition = imageAnchor.referenceImage.physicalSize.width * 1.4
                let initialZPosition = imageAnchor.referenceImage.physicalSize.height * 0.71

                plane.firstMaterial?.diffuse.contents = UIColor(white: 1, alpha: 0)
                planeNode.eulerAngles.x = -.pi / 2

                inforNode.position.x = Float(initialXPosition)
                inforNode.position.z = Float(initialZPosition)
                inforNode.eulerAngles.x = -.pi / 2

                InformationView().createHostingController(
                    for: inforNode,
                    width: UIScreen.main.bounds.width * 0.8,
                    height: UIScreen.main.bounds.height * 0.8
                )

                node.addChildNode(planeNode)
                node.addChildNode(inforNode)
                if let elementScene = SCNScene(named: "art.scnassets/\(imageName).scn") {
                    if let elementNode = elementScene.rootNode.childNodes.first {
                        elementNode.eulerAngles.x = .pi / 2
                        elementNode.scale = SCNVector3(x: 0.005, y: 0.005, z: 0.005)
                        planeNode.addChildNode(elementNode)
                    }
                }
            }
            return node
        }
    }
}
