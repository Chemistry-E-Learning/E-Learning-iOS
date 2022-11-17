//
//  ReactionHttpMapper.swift
//  ChemistryAR
//
//  Created by NhatMinh on 15/11/2022.
//

import Foundation

struct ReactionHttpMapper {
    static func map(entity: ReactionHttpEntity) -> Reaction {
        return Reaction(
            reactants: entity.reactants,
            chemicalEquation: entity.chemicalEquation
        )
    }
}
