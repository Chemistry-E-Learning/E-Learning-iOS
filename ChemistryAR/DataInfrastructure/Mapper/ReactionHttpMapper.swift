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

struct ChemicalHttpMapper {
    static func map(entity: ChemicalsListHttpEntity) -> ChemicalsList {
        let liquidChemicals = entity.liquidChemicals.contents.map {
            Chemical(
                id: $0.id,
                name: $0.name,
                description: $0.description,
                formula: $0.formula,
                imageURL: $0.image.url,
                color: $0.color,
                standardState: ChemicalHttpMapper.getState($0.standardState.first ?? ""),
                category: ChemicalHttpMapper.getCategory($0.category.first ?? "")
            )
        }
        let solidChemicals = entity.solidChemicals.contents.map {
            Chemical(
                id: $0.id,
                name: $0.name,
                description: $0.description,
                formula: $0.formula,
                imageURL: $0.image.url,
                color: $0.color,
                standardState: ChemicalHttpMapper.getState($0.standardState.first ?? ""),
                category: ChemicalHttpMapper.getCategory($0.category.first ?? "")
            )
        }
        let gasChemicals = entity.gasChemicals.contents.map {
            Chemical(
                id: $0.id,
                name: $0.name,
                description: $0.description,
                formula: $0.formula,
                imageURL: $0.image.url,
                color: $0.color,
                standardState: ChemicalHttpMapper.getState($0.standardState.first ?? ""),
                category: ChemicalHttpMapper.getCategory($0.category.first ?? "")
            )
        }
        return ChemicalsList(
            liquidChemicals: liquidChemicals,
            solidChemicals: solidChemicals,
            gasChemicals: gasChemicals
        )
    }

    static func getState(_ state: String) -> ChemicalState {
        switch state {
        case "liquid":
            return .liquid
        case "solid":
            return .solid
        case "gas":
            return .gas
        default:
            return .liquid
        }
    }

    static func getCategory(_ category: String) -> ChemicalCategory {
        switch category {
        case "acid":
            return .acid
        case "base":
            return .base
        case "salt":
            return .salt
        case "metal":
            return .metal
        case "gas":
            return .gas
        case "oxide":
            return .oxide
        default:
            return .acid
        }
    }
}
