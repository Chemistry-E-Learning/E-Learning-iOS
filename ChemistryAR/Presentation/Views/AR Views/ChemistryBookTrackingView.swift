//
//  ChemistryBookTrackingView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 24/11/2022.
//

import SwiftUI
import Foundation
import SceneKit
import ARKit

struct ChemistryBookTrackingView: View {
    @StateObject private var viewModel = ChemistryBookTrackingViewModel()
    @State private var isTracking = false
    @State private var entityName = ""
    var body: some View {
        ZStack {
            ChemistryBookTrackingARView(
                viewModel: viewModel,
                isTracking: $isTracking,
                entityName: $entityName
            )
        }
        .onChange(of: isTracking) { _ in
            if isTracking {
                viewModel.doGetEntityDetail(with: entityName)
                isTracking = false
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ChemistryBookTrackingARView: UIViewRepresentable {
    @ObservedObject var viewModel: ChemistryBookTrackingViewModel
    @Binding var isTracking: Bool
    @Binding var entityName: String

    var sceneView = ARSCNView(frame: .zero)

    func makeCoordinator() -> BookCoordinator {
        BookCoordinator(
            viewModel: _viewModel,
            isTracking: $isTracking,
            entityName: $entityName
        )
    }

    func makeUIView(context: Context) -> ARSCNView {
        guard let referenceImages = ARReferenceImage.referenceImages(
            inGroupNamed: AppConstant.ChemistryBookResource,
            bundle: nil)
        else {
            fatalError(AppConstant.NoAsset)
        }

        let configuration = ARWorldTrackingConfiguration()
        configuration.isAutoFocusEnabled = true
        configuration.detectionImages = referenceImages
        configuration.maximumNumberOfTrackedImages = AppConstant.MaximumImageTracking

        sceneView.delegate = context.coordinator
        sceneView.showsStatistics = true
        sceneView.autoenablesDefaultLighting = true
        sceneView.automaticallyUpdatesLighting = true
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        return sceneView
    }

    func updateUIView(_ uiView: ARSCNView, context: Context) {
    }
}

class BookCoordinator: NSObject, ARSCNViewDelegate {
    @ObservedObject var viewModel: ChemistryBookTrackingViewModel
    @Binding var isTracking: Bool
    @Binding var entityName: String

    init(viewModel: ObservedObject<ChemistryBookTrackingViewModel>, isTracking: Binding<Bool>, entityName: Binding<String>) {
        _viewModel = viewModel
        _isTracking = isTracking
        _entityName = entityName
    }

    // MARK: - Anchor Method
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
        trackingImage(anchor: anchor, node: node)
        return node
    }

    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        if let imageAnchor = anchor as? ARImageAnchor, let _ = imageAnchor.name {
            if imageAnchor.isTracked && viewModel.currentModel != nil && node.childNodes.count <= 0 {
                let physicalSize = imageAnchor.referenceImage.physicalSize
                let plane = SCNPlane(width: physicalSize.width, height: physicalSize.height)
                let planeNode = SCNNode(geometry: plane)
                planeNode.eulerAngles.x = -.pi / 2
                plane.firstMaterial?.diffuse.contents = UIColor(white: 1, alpha: 1)
                if let model = viewModel.currentModel {
                    addModelEntityInNode(
                        modelName: model.name,
                        scale: model.scale,
                        position: model.position,
                        for: planeNode,
                        with: physicalSize
                    )
                }
                node.addChildNode(planeNode)
            }
        }
    }

    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
    }

    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
    }
}

// MARK: - Logic Function
private extension BookCoordinator {
    func trackingImage(anchor: ARAnchor, node: SCNNode) {
        if let imageAnchor = anchor as? ARImageAnchor, let imageName = imageAnchor.name {
            DispatchQueue.main.async {
                self.viewModel.currentModel = nil
            }
            viewModel.doGetEntityDetail(with: imageName)
            #warning("TODO: MinhNN44 - Remove later")
            let physicalSize = imageAnchor.referenceImage.physicalSize
            let plane = SCNPlane(width: physicalSize.width, height: physicalSize.height)
            let planeNode = SCNNode(geometry: plane)
            planeNode.eulerAngles.x = -.pi / 2
            plane.firstMaterial?.diffuse.contents = UIColor(white: 1, alpha: 1)
            addModelEntityInNode(
                modelName: "geometrie-molecolari",
                scale: SCNVector3(x: 0.5, y: 0.5, z: 0.5),
                position: SCNVector3(x: 0, y: 0, z: 0),
                for: planeNode,
                with: physicalSize
            )
            node.addChildNode(planeNode)


        }
    }

    func addModelEntityInNode(
        modelName: String,
        scale: SCNVector3,
        position: SCNVector3,
        for node: SCNNode,
        with physicalSize: CGSize
    ) {
        if let elementScene = SCNScene(named: "art.scnassets/\(modelName).scn") {
            if let elementNode = elementScene.rootNode.childNodes.first {
                print("MinhNN44 - \(modelName)")
                elementNode.position = position
                elementNode.scale = scale
                node.addChildNode(elementNode)
            }
        }
    }
}
