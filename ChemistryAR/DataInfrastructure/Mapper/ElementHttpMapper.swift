//
//  ElementHttpMapper.swift
//  ChemistryAR
//
//  Created by NhatMinh on 14/11/2022.
//

import Foundation
import SceneKit

struct ElementHttpMapper {
    static func map(entity: ElementHttpEntity) -> ElementDetail {
        let models = entity.models?.map({ model in
            return Element3DModel(
                name: model.name,
                scale: SCNVector3(x: model.scale?.xVector ?? 1, y:  model.scale?.yVector ?? 1, z:  model.scale?.zVector ?? 1),
                position: SCNVector3(x: model.position?.xVector ?? 0, y:  model.position?.yVector ?? 0, z:  model.position?.zVector ?? 0),
                angle: (model.angle ?? 0) / 180
            )
        })
        return ElementDetail(
            id: entity.id,
            name: entity.name,
            symbol: entity.symbol,
            summary: entity.summary,
            appearance: entity.appearance,
            atomicMass: entity.atomicMass,
            boil: entity.boil,
            group: ElementHttpMapper.getElementGroup(name: entity.group),
            density: entity.density,
            melt: entity.melt,
            molarHeat: entity.molarHeat,
            discoveredBy: entity.discoveredBy,
            namedBy: entity.namedBy,
            number: entity.number,
            period: entity.period,
            phase: ElementHttpMapper.getPhase(phase: entity.phase),
            source: entity.source,
            mainImage: entity.mainImage,
            spectralImage: entity.spectralImage,
            structureImage: entity.structureImage,
            configuration: entity.configuration,
            electronAffinity: entity.electronAffinity,
            electronegativity: entity.electronegativity,
            ionizationEnergies: entity.ionizationEnergies,
            chemotherapy: entity.chemotherapy,
            tag: NoticeTag(rawValue: entity.tag ?? ""),
            models: models
        )
    }

    static func getElementGroup(name: String) -> ElementGroup {
        switch name {
        case "Diatomic Nonmetal":
            return .diatomicNonMetal
        case "Polyatomic Nonmetal":
            return .polyatomicNonMetal
        case "Alkali":
            return .alkali
        case "Alkali Earth":
            return .alkaliEarth
        case "Transition Metal":
            return .transitionMetal
        case "Post Transition Metal":
            return .postTransitionMetal
        case "Metalloid":
            return .metalloid
        case "Halogen":
            return .halogen
        case "Noble Gas":
            return .noble
        case "Lanthanoid":
            return .lanthanoid
        case "Actinide":
            return .actinide
        default:
            return .initial
        }
    }

    static func getPhase(phase: String) -> Phase {
        switch phase {
        case "Gas":
            return .gas
        case "Solid":
            return .solid
        case "Liquid":
            return .liquid
        default: return .gas
        }
    }
}
