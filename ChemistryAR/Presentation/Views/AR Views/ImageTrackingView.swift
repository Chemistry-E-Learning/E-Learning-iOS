//
//  ImageTrackingView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 21/09/2022.
//

import SwiftUI
import Foundation
import RealityKit
import ARKit

struct ImageTrackingView: View {
    @State private var isShowInformationView = false

    var body: some View {
        ZStack {
            ImageTrackingARView()
        }
            .edgesIgnoringSafeArea(.all)
    }
}

struct ImageTrackingARView: UIViewRepresentable {
    var arView = ARView(frame: .zero, cameraMode: .ar, automaticallyConfigureSession: true)

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }


    func makeUIView(context: Context) -> ARView {
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

        arView.session.delegate = context.coordinator
        arView.session.run(configuration)
        return arView
    }

     func updateUIView(_ uiView: ARView, context: Context) {
    }

    class Coordinator: NSObject, ARSessionDelegate {
        var parent: ImageTrackingARView
        lazy var drawableTextureManager: DrawableTextureManager = DrawableTextureManager()

        init(parent: ImageTrackingARView) {
            self.parent = parent
        }

        func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
            for anchor in anchors {
                //                guard let imageAnchor = anchor as? ARImageAnchor, let imageName = imageAnchor.name else { return }
                //                let physicSize = imageAnchor.referenceImage.physicalSize
                //                let imageAnchorEntity = AnchorEntity(anchor: imageAnchor)
                //                let filename = "\(imageName).usdz"
                //                let modelEntity = try! ModelEntity.loadModel(named: filename)
                //                let rotationAngle = simd_quatf(
                //                    angle: GLKMathDegreesToRadians(-90),
                //                    axis: SIMD3(x: 1, y: 0, z: 0)
                //                )
                //                drawableTextureManager.update(with: UIView(frame: CGRect(x: 0, y: 0, width: physicSize.width, height: physicSize.height)))
                //                let entity = ModelEntity(
                //                    mesh: .generatePlane(width: 0.5, height: 0.5),
                //                    materials: [drawableTextureManager.customMaterial]
                //                )
                //                entity.setOrientation(rotationAngle, relativeTo: imageAnchorEntity)
                //                entity.setPosition(SIMD3(x: Float(physicSize.width * 1.2 ), y: 0, z: 0), relativeTo: imageAnchorEntity)
                //                imageAnchorEntity.addChild(entity)
                //                modelEntity.generateCollisionShapes(recursive: true)
                //                modelEntity.setOrientation(rotationAngle, relativeTo: imageAnchorEntity)
                //                imageAnchorEntity.addChild(modelEntity)
                //                parent.arView.installGestures([.translation, .scale], for: modelEntity)
                //                parent.arView.scene.addAnchor(imageAnchorEntity)
            }
        }

        func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        }
    }
}
