//
//  Reaction.swift
//  ChemistryAR
//
//  Created by NhatMinh on 15/11/2022.
//

import Foundation

struct Reaction {
    let reactants: [String]
    let chemicalEquation: [String]

    static let emptyData = Reaction(reactants: [], chemicalEquation: [])
}
