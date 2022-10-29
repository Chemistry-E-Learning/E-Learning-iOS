//
//  ViewExtension.swift
//  ChemistryAR
//
//  Created by NhatMinh on 17/09/2022.
//

import SwiftUI
import SceneKit

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }

    func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }

    func getScreenBounds() -> CGRect {
        return UIScreen.main.bounds
    }

    func createHostingController(for node: SCNNode, width: CGFloat, height: CGFloat) {
        DispatchQueue.main.async {
            let arVC = UIHostingController(rootView: self)
            arVC.view.backgroundColor = UIColor.clear
            arVC.view.frame = CGRect(x: 0, y: 0, width: width, height: height)
            let material = SCNMaterial()
            arVC.view.isOpaque = false
            material.diffuse.contents = arVC.view
            node.geometry?.materials = [material]
        }
    }

    func getSafeArea(edge: Edge) -> CGFloat {
        let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
        switch edge {
        case .top:
            return (keyWindow?.safeAreaInsets.top) ?? 20.0
        case .leading:
            return (keyWindow?.safeAreaInsets.left) ?? 0.0
        case .bottom:
            return (keyWindow?.safeAreaInsets.bottom) ?? 20.0
        case .trailing:
            return (keyWindow?.safeAreaInsets.right) ?? 0.0
        }
    }

    func customOffset(_ point: CGPoint) -> some View {
        return self.offset(x: point.x, y: point.y)
    }

    func squareFrame(_ size: CGFloat) -> some View {
        return self.frame(width: size, height: size)
    }
}

// MARK: - RoundedCorner
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
