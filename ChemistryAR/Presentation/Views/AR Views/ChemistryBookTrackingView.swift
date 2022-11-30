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
import AVKit

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
    private var avPlayer = AVPlayer()

    init(
        viewModel: ObservedObject<ChemistryBookTrackingViewModel>,
        isTracking: Binding<Bool>,
        entityName: Binding<String>
    ) {
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
        if let imageAnchor = anchor as? ARImageAnchor, let imageName = imageAnchor.name {
            guard let model = viewModel.currentModel else { return }
            if imageAnchor.isTracked && node.childNodes.count <= 0 {
                let physicalSize = imageAnchor.referenceImage.physicalSize
                let plane = SCNPlane(
                    width: physicalSize.width,
                    height: physicalSize.height
                )
                let planeNode = SCNNode(geometry: plane)
                planeNode.eulerAngles.x = -.pi / 2

                if imageName.contains("video"), let videoURL = URL(string: model.name) {
                    avPlayer = AVPlayer(url: videoURL)
                    plane.firstMaterial?.diffuse.contents = avPlayer
                    node.addChildNode(planeNode)
                    avPlayer.play()
                } else {
                    addModelEntityInNode(
                        modelName: model.name,
                        scale: model.scale,
                        position: model.position,
                        for: planeNode,
                        with: physicalSize
                    )
                    node.addChildNode(planeNode)
                }
            } else if !imageAnchor.isTracked && imageName.contains("video") {
                avPlayer.pause()
            } else if imageAnchor.isTracked && imageName.contains("video") {
                avPlayer.play()
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
