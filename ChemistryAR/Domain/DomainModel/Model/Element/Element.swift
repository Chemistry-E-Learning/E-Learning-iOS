//
//  Element.swift
//  ChemistryAR
//
//  Created by NhatMinh on 14/11/2022.
//

import Foundation

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

    static let emptyData = ElementDetail(
        id: "",
        name: "",
        symbol: "",
        summary: "",
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
        tag: nil
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
