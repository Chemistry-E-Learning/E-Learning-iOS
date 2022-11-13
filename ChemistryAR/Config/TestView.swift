//
//  TestView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 19/10/2022.
//

import SwiftUI
import SceneKit

struct SceneView: UIViewRepresentable {
    let scene = SCNScene()

    func makeUIView(context: Context) -> SCNView {

        // create a box
        scene.rootNode.addChildNode(createBox())

        // code for creating the camera and setting up lights is omitted for simplicity
        // …

        // retrieve the SCNView
        let scnView = SCNView()
    scnView.scene = scene
        return scnView
    }

    func updateUIView(_ scnView: SCNView, context: Context) {
        scnView.scene = scene

        // allows the user to manipulate the camera
        scnView.allowsCameraControl = true

        // configure the view
        scnView.backgroundColor = UIColor.gray

        // show statistics such as fps and timing information
        scnView.showsStatistics = true
        scnView.debugOptions = .showWireframe
    }

    func createBox() -> SCNNode {
        let boxGeometry = SCNBox(width: 20, height: 24, length: 40, chamferRadius: 0)
        let box = SCNNode(geometry: boxGeometry)
        box.name = "box"
        return box
    }

    func removeBox() {
        // check if box exists and remove it from the scene
        guard let box = scene.rootNode.childNode(withName: "box", recursively: true) else { return }
        box.removeFromParentNode()
    }

    func addBox() {
        // check if box is already present, no need to add one
        if scene.rootNode.childNode(withName: "box", recursively: true) != nil {
            return
        }
        scene.rootNode.addChildNode(createBox())
    }
}

struct HUDView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center, spacing: 2) {
                Spacer()

                ButtonView(action: {}, icon: "plus.square.fill", isActive: false)
                ButtonView(action: {}, icon: "minus.square.fill")
                ButtonView(action: {}) // just a dummy button
            }
            .background(Color.white.opacity(0.2))

            Spacer()
        }
    }
}

struct MainView: View {
    var body: some View {
        ZStack {
            SceneView()

            HUDView()
        }
    }
}

struct ButtonView: View {
    let action: () -> Void
    var icon: String = "square"
    @State var isActive: Bool = true

    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.title)
                .accentColor(isActive ? Color.white : Color.white.opacity(0.5))
        }
        .frame(width: 44, height: 44)
    }
}
