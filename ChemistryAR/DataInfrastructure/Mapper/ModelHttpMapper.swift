//
//  ModelHttpMapper.swift
//  ChemistryAR
//
//  Created by NhatMinh on 24/11/2022.
//

import Foundation
import SceneKit

struct ModelHttpMapper {
    static func map(entity: ModelHttpEntity) -> Element3DModel {
        return Element3DModel(
            name: entity.name,
            scale: ModelHttpMapper.convertVectorToSCNVector(entity.scale),
            position: ModelHttpMapper.convertVectorToSCNVector(entity.position, isScale: false),
            angle: (entity.angle ?? 0 ) / 180
        )
    }

    static func convertVectorToSCNVector(_ CMSVector: VectorModel?, isScale: Bool = true) -> SCNVector3 {
        if let vector = CMSVector {
            return SCNVector3(x: vector.xVector, y: vector.yVector, z: vector.zVector)
        }
        return isScale ? SCNVector3(x: 1, y: 1, z: 1) : SCNVector3(x: 0, y: 0, z: 0)
    }
}
