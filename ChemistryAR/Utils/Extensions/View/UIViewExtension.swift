//
//  UIViewExtension.swift
//  ChemistryAR
//
//  Created by NhatMinh on 26/09/2022.
//

import Metal
import UIKit

extension UIView {
    func takeTextureSnapshot(device: MTLDevice) -> MTLTexture? {
        let width = Int(bounds.width)
        let height = Int(bounds.height)
        if let context = CGContext(
            data: nil,
            width: width,
            height: height,
            bitsPerComponent: 8,
            bytesPerRow: 0,
            space: CGColorSpaceCreateDeviceRGB() ,
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue  | CGBitmapInfo.byteOrder32Big.rawValue
        ),
           let data = context.data {
            layer.render(in: context)
            let desc = MTLTextureDescriptor.texture2DDescriptor(
                pixelFormat: .rgba8Unorm,
                width: width,
                height: height,
                mipmapped: false
            )
            if let texture = device.makeTexture(descriptor: desc) {
                texture.replace(
                    region: MTLRegionMake2D(0, 0, width, height),
                    mipmapLevel: 0,
                    withBytes: data,
                    bytesPerRow: context.bytesPerRow
                )
                return texture
            }
        }
        return nil
    }
}
