//
//  ColorExtension.swift
//  ChemistryAR
//
//  Created by NhatMinh on 17/09/2022.
//

import SwiftUI
import UIKit

public extension Color {
    // static let cF1CC45 = Color(hex: 0xF1CC45)

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
