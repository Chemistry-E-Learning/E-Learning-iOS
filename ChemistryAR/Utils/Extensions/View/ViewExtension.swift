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

    func swipeBack(
        isPresented: Binding<Bool>,
        maxTranslation: CGFloat
    ) -> some View {
        modifier(
            SwipeBackViewModifier(isPresented: isPresented, maxTranslation: maxTranslation)
        )
    }


    @ViewBuilder
    func redacted(if condition: @autoclosure () -> Bool) -> some View {
        redacted(reason: condition() ? .placeholder : [])
            .if(condition()) { view in
                view.shimmerAnimation()
            }
    }

    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }

    func shimmerAnimation() -> some View {
        modifier(ShimmerViewModifier())
    }
}

struct EmptyViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
    }
}
struct ShimmerViewModifier: ViewModifier {
    @State var isAnimating = false
    let center = UIScreen.main.bounds.width / 2

    func body(content: Content) -> some View {
        content
            .mask {
                ZStack {
                    Color.black.opacity(0.8)
                    Rectangle()
                        .fill(LinearGradient(gradient: .init(colors: [.clear, .white, .clear]), startPoint: .top, endPoint: .bottom))
                        .rotationEffect(.init(degrees: 70))
                        .offset(x: isAnimating ? center : -center)
                        .animation(Animation.default.speed(0.25).delay(0).repeatForever(autoreverses: false), value: isAnimating)
                }
            }
            .onAppear {
                isAnimating.toggle()
            }
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
