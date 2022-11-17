//
//  ElementInformationModel.swift
//  ChemistryAR
//
//  Created by NhatMinh on 15/11/2022.
//

import Foundation

struct OverviewModel {
    let name: String
    let description: String
    let period: Int
    let group: String
    let discoveredBy: String
    let nameBy: String
    let structureImage: String?

    static let emptyData = OverviewModel(
        name: "",
        description: "",
        period: 0,
        group: "",
        discoveredBy: "",
        nameBy: "",
        structureImage: nil
    )
}

struct NatureModel {
    let standardState: String
    let atomicMass: Double?
    let density: Double?
    let melt: Double?
    let boil: Double?
    let molarHeat: Double?

    static let emptyData = NatureModel(
        standardState: "",
        atomicMass: 0,
        density: 0,
        melt: 0,
        boil: 0,
        molarHeat: 0
    )
}

struct AtomParameter {
    let electronConfiguration: String
    let chemotherapy: [Int]
    let spectralImage: String?
    let electronAffinity: Double?
    let electronegativity: Double?
    let ionizationEnergies: Double?

    static let emptyData = AtomParameter(
        electronConfiguration: "",
        chemotherapy: [],
        spectralImage: nil,
        electronAffinity: 0,
        electronegativity: 0,
        ionizationEnergies: 0
    )
}
