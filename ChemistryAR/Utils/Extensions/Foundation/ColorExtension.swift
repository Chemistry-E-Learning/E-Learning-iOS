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
