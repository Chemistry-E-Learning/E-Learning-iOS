//
//  Chemical.swift
//  ChemistryAR
//
//  Created by NhatMinh on 19/11/2022.
//

import Foundation

struct ChemicalsList {
    let liquidChemicals: [Chemical]
    let solidChemicals: [Chemical]
    let gasChemicals: [Chemical]

    static let emptyData = ChemicalsList(liquidChemicals: [], solidChemicals: [], gasChemicals: [])
}

struct Chemical: Identifiable, Equatable {
    static func == (lhs: Chemical, rhs: Chemical) -> Bool {
        lhs.formula == rhs.formula
    }

    let id: String
    let name: String?
    let description: String?
    let formula: String
    let imageURL: String
    let color: CMSColor
    let standardState: ChemicalState
    let category: ChemicalCategory
}

public enum ChemicalState: String {
    case liquid
    case solid
    case gas
}

public enum ChemicalCategory: String {
    case acid
    case base
    case salt
    case metal
    case gas
    case oxide
}
