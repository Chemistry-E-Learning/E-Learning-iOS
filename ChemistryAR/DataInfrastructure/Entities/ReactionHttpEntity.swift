//
//  ReactionHttpEntity.swift
//  ChemistryAR
//
//  Created by NhatMinh on 15/11/2022.
//

import Foundation

struct ReactionHttpEntity: Codable {
    let reactants: [String]
    let chemicalEquation: [String]
}
