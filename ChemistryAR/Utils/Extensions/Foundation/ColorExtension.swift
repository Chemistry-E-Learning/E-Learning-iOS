//
//  ColorExtension.swift
//  ChemistryAR
//
//  Created by NhatMinh on 17/09/2022.
//

import SwiftUI
import UIKit

public extension Color {
    static let mainColor = Color(hex: 0x104A51)
    static let c4A4A4A = Color(hex: 0x4A4A4A)
    static let cE1E1E1 = Color(hex: 0xE1E1E1)
    static let c081645 = Color(hex: 0x081645)
    static let c7A2F81 = Color(hex: 0x7A2F81)
    static let c5398FF = Color(hex: 0x5398FF)
    static let c3686FF = Color(hex: 0x3686FF)
    static let cA3C8FF = Color(hex: 0xA3C8FF)
    static let cFF8686 = Color(hex: 0xFF8686)
    static let cFF5757 = Color(hex: 0xFF5757)
    static let cF7F9FC = Color(hex: 0xF7F9FC)
    static let cFFD335 = Color(hex: 0xFFD335)
    static let c444444 = Color(hex: 0x444444)
    static let c2A323F = Color(hex: 0x2A323F)
    static let c225096 = Color(hex: 0x225096)
    static let cBF2121 = Color(hex: 0xBF2121)
    static let c1A1F2C = Color(hex: 0x1A1F2C)

    // MARK: - Element Group Color
    static let diatomicNonMetal = Color(hex: 0x2F3168)
    static let polyatomicNonMetal = Color(hex: 0x2F3168)
    static let alkali = Color(hex: 0x602B39)
    static let alkaliEarth = Color(hex: 0x513E35)
    static let transitionMetal = Color(hex: 0x333E51)
    static let postTransitionMetal = Color(hex: 0x1B5643)
    static let metalloid = Color(hex: 0x154959)
    static let halogen = Color(hex: 0x424181)
    static let noble = Color(hex: 0x4A2D6D)
    static let lanthanoid = Color(hex: 0x403361)
    static let actinide = Color(hex: 0x382349)

    // MARK: - LinearGradient
    static let virtualLabBGC = LinearGradient(
        gradient: Gradient(colors: [.c3686FF, .c5398FF.opacity(0.8)]),
        startPoint: .top,
        endPoint: .bottom
    )

    static let startButton = LinearGradient(
        colors: [.cFF5757, .cFF8686],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    /// color initalizer
    /// - Parameters:
    ///   - hex: UInt
    ///   - alpha: Double = 1
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}

extension UIColor {
    func image(_ size: CGSize = CGSize(width: 200, height: 200)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}
