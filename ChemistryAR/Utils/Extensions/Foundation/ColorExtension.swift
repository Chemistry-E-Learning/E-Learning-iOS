//
//  ColorExtension.swift
//  ChemistryAR
//
//  Created by NhatMinh on 17/09/2022.
//

import SwiftUI
import UIKit

public extension Color {
    static let c4A4A4A = Color(hex: 0x4A4A4A)
    static let cE1E1E1 = Color(hex: 0xE1E1E1)
    static let c081645 = Color(hex: 0x081645)
    static let c7A2F81 = Color(hex: 0x7A2F81)

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
