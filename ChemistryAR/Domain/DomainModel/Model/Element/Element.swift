//
//  Element.swift
//  ChemistryAR
//
//  Created by NhatMinh on 14/11/2022.
//

import Foundation
import SceneKit

struct ElementDetail: Identifiable {
    let id: String
    let name: String
    let symbol: String
    let summary: String
    let appearance: String?
    let atomicMass: Double?
    let boil: Double?
    let group: ElementGroup
    let density: Double?
    let melt: Double?
    let molarHeat: Double?
    let discoveredBy: String?
    let namedBy: String?
    let number: Int
    let period: Int
    let phase: Phase
    let source: String
    let mainImage: CMSImage
    let spectralImage: CMSImage?
    let structureImage: CMSImage?
    let configuration: String
    let electronAffinity: Double?
    let electronegativity: Double?
    let ionizationEnergies: Double?
    let chemotherapy: [Int]?
    let tag: NoticeTag?
    let models: [Element3DModel]?

    static let emptyData = ElementDetail(
        id: "",
        name: AppConstant.ShortText,
        symbol: "NIL",
        summary: AppConstant.LongText,
        appearance: "",
        atomicMass: 0,
        boil: 0,
        group: .initial,
        density: 0,
        melt: 0,
        molarHeat: 0,
        discoveredBy: "",
        namedBy: "",
        number: 0,
        period: 0,
        phase: .gas,
        source: "",
        mainImage: CMSImage(url: ""),
        spectralImage: CMSImage(url: ""),
        structureImage: CMSImage(url: ""),
        configuration: "",
        electronAffinity: 0,
        electronegativity: 0,
        ionizationEnergies: 0,
        chemotherapy: [],
        tag: nil,
        models: nil
    )
}

enum NoticeTag: String {
    case radiation = "Radioactive"
    case theoreticalElement = "Theoretical Element"

    func getGroupName() -> String {
        switch self {
        case .radiation:
            return Localization.radiationTitle.localizedString
        case .theoreticalElement:
            return Localization.theoreticalElementTitle.localizedString
        }
    }
}

struct Element3DModel: Identifiable {
    let id = UUID()
    let name: String
    let scale: SCNVector3
    let position: SCNVector3
    let angle: Float
    
    static var emptyData = Element3DModel(
        name: "",
        scale: SCNVector3(x: 1, y: 1, z: 1),
        position: SCNVector3(x: 0, y: 0, z: 0),
        angle: .pi / 5
    )

    static var dummyData = [
        Element3DModel(
            name: "copper",
            scale: SCNVector3(x: 1, y: 1, z: 1),
            position: SCNVector3(x: 0, y: 0, z: 0),
            angle: .pi / 5
        ),
        Element3DModel(
            name: "centered-cube",
            scale: SCNVector3(x: 0.7, y: 0.7, z: 0.7),
            position: SCNVector3(x: -0.002, y: -0.015, z: 0),
            angle: 0
        ),
        Element3DModel(
            name: "copper_card",
            scale: SCNVector3(x: 0.6, y: 0.6, z: 0.6),
            position: SCNVector3(x: -0.002, y: -0.01, z: 0),
            angle: .pi / 5
        )
    ]
}
