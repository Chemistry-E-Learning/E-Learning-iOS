//
//  ElementHttpEntity.swift
//  ChemistryAR
//
//  Created by NhatMinh on 14/11/2022.
//

import Foundation

struct ElementHttpEntity: Codable {
    let id: String
    let name: String
    let symbol: String
    let summary: String
    let appearance: String?
    let atomicMass: Double?
    let boil: Double?
    let group: String
    let density: Double?
    let melt: Double?
    let molarHeat: Double?
    let discoveredBy: String?
    let namedBy: String?
    let number: Int
    let period: Int
    let phase: String
    let source: String
    let mainImage: CMSImage
    let spectralImage: CMSImage?
    let structureImage: CMSImage?
    let configuration: String
    let electronAffinity: Double?
    let electronegativity: Double?
    let ionizationEnergies: Double?
    let chemotherapy: [Int]?
    let tag: String?
}
