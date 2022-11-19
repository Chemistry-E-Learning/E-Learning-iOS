//
//  ChemicalHttpEntity.swift
//  ChemistryAR
//
//  Created by NhatMinh on 19/11/2022.
//

import Foundation

struct ChemicalsListHttpEntity: Codable {
    let liquidChemicals: CommonHttpEntity<ChemicalHttpEntity>
    let solidChemicals: CommonHttpEntity<ChemicalHttpEntity>
    let gasChemicals: CommonHttpEntity<ChemicalHttpEntity>
}

struct ChemicalHttpEntity: Codable {
    let id: String
    let name: String?
    let description: String?
    let formula: String
    let image: CMSImage
    let color: CMSColor
    let standardState: [String]
    let category: [String]
}

struct CMSColor: Codable {
    let hexColor: String
    let opacity: Double
}
