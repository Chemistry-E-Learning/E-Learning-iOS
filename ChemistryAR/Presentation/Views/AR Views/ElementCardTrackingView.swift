//
//  ImageTrackingView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 21/09/2022.
//

import SwiftUI
import Foundation
import SceneKit
import ARKit

struct ElementCardTrackingView: View {
    @StateObject private var viewModel = ElementCardTrackingViewModel()
    @State private var reactants = [String: String]()
    @State private var reactantsTracking = [String]()

    var body: some View {
        ZStack {
            ImageTrackingARView(
                reactants: $reactants,
                reactantsTracking: $reactantsTracking,
                chemicalEquation: $viewModel.chemicalEquation
            )
            if viewModel.chemicalEquation.count > 0 {
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(viewModel.chemicalEquation, id: \.self) { item in
                        Text(item)
                            .font(.system(size: 24, weight: .medium))
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
                .background(Color.white.opacity(0.6).cornerRadius(12))
                .rotationEffect(.init(degrees: -90))
            }
        }
        .onChange(of: reactantsTracking) { _ in
            if reactantsTracking.count == 2 {
                // Call api reaction
                viewModel.doGetReactionResult(with: reactantsTracking)
            } else {
                viewModel.reactants = []
                viewModel.chemicalEquation = []
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ImageTrackingARView: UIViewRepresentable {
    @Binding var reactants: [String: String]
    @Binding var reactantsTracking: [String]
    @Binding var chemicalEquation: [String]
    var sceneView = ARSCNView(frame: .zero)

    func makeCoordinator() -> Coordinator {
        Coordinator(
            reactants: $reactants,
            reactantsTracking: $reactantsTracking,
            chemicalEquation: $chemicalEquation
        )
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

class Coordinator: NSObject, ARSCNViewDelegate {
    @Binding var reactants: [String: String]
    @Binding var reactantsTracking: [String]
    @Binding var chemicalEquation: [String]

    init(
        reactants: Binding<[String: String]>,
        reactantsTracking: Binding<[String]>,
        chemicalEquation: Binding<[String]>

    ) {
        _reactants = reactants
        _reactantsTracking = reactantsTracking
        _chemicalEquation = chemicalEquation
    }

    // MARK: - Anchor Method
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
        trackingImage(anchor: anchor, node: node)
        return node
    }

    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        if let imageAnchor = anchor as? ARImageAnchor, let imageName = imageAnchor.name {
            let imageNameSeparator = imageName.split(separator: "-")
            let modelName = String(imageNameSeparator.first ?? "")
            let isBackSize = imageNameSeparator.count == 2 && imageNameSeparator.last ?? "" == AppConstant.BackSide
            var symbol = ""
            // Remove chemical when lose tracking
            if imageAnchor.isTracked && isBackSize {
                if reactants.contains(where: { (key, value) in
                    symbol = value
                    return key == modelName
                }) {
                    if !reactantsTracking.contains(where: { item in
                        item == symbol
                    }) {
                        reactantsTracking.append(symbol)
                    }
                }
            } else {
                reactantsTracking = reactantsTracking.filter { $0 != reactants[modelName]}
            }
        }
    }

    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
    }

    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
    }
}

// MARK: - Logic Function
private extension Coordinator {
    func trackingImage(anchor: ARAnchor, node: SCNNode) {
        if let imageAnchor = anchor as? ARImageAnchor, let imageName = imageAnchor.name {
            let physicalSize = imageAnchor.referenceImage.physicalSize
            let imageNameSeparator = imageName.split(separator: "-")
            let modelName = String(imageNameSeparator.first ?? "")
            let isBackSize = imageNameSeparator.count == 2 && imageNameSeparator.last ?? "" == AppConstant.BackSide

            addElement3DInARWord(
                in: node,
                with: physicalSize,
                and: imageAnchor,
                isBackSize: isBackSize,
                modelName: modelName
            )
        }
    }

    func addElement3DInARWord(
        in node: SCNNode,
        with physicalSize: CGSize,
        and imageAnchor: ARImageAnchor,
        isBackSize: Bool,
        modelName: String
    ) {
        let plane = SCNPlane(width: physicalSize.width, height: physicalSize.height)
        let planeNode = SCNNode(geometry: plane)
        planeNode.eulerAngles.x = -.pi / 2

        if isBackSize {
            ChemicalView(
                reactants: $reactants,
                elementName: modelName,
                size: physicalSize
            )
                .createHostingController(
                    for: planeNode,
                    width: physicalSize.width * 100,
                    height: physicalSize.height * 100
                )
        } else {
            plane.firstMaterial?.diffuse.contents = UIColor(white: 1, alpha: 0)
            addInformationViewInARWord(
                in: node,
                with: physicalSize,
                imageAnchor: imageAnchor,
                imageName: modelName
            )
        }

        addModelEntityInNode(
            modelName: modelName,
            scale: SCNVector3(x: 0.04, y: 0.04, z: 0.04),
            for: planeNode,
            with: physicalSize
        )
        node.addChildNode(planeNode)
    }

    func addInformationViewInARWord(
        in node: SCNNode,
        with physicSize: CGSize,
        imageAnchor: ARImageAnchor,
        imageName: String
    ) {
        let infoPlane = SCNPlane(width: physicSize.width * 1.6, height: physicSize.height * 2.5)
        let infoNode = SCNNode(geometry: infoPlane)
        let initialXPosition = physicSize.width * 1.4
        infoNode.position.x = Float(initialXPosition)
        infoNode.eulerAngles.x = -.pi / 2
        InformationView(elementName: imageName)
            .createHostingController(
                for: infoNode,
                width: UIScreen.main.bounds.width * 0.8,
                height: UIScreen.main.bounds.height * 0.8
            )
        node.addChildNode(infoNode)
    }

    func addModelEntityInNode(
        modelName: String,
        scale: SCNVector3,
        for node: SCNNode,
        with physicalSize: CGSize
    ) {
        if let elementScene = SCNScene(named: "art.scnassets/\(modelName).scn") {
            if let elementNode = elementScene.rootNode.childNodes.first {
                elementNode.position.z = Float(physicalSize.width * 0.6)
                elementNode.eulerAngles.x = .pi / 2
                elementNode.scale = scale
                node.addChildNode(elementNode)
            }
        }
    }
}
