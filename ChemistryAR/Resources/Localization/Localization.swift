//
//  Localization.swift
//  ChemistryAR
//
//  Created by NhatMinh on 17/09/2022.
//

import Foundation

enum Localization: String {
    case startButtonTitle
    case welcomeBackTitle
    case classProgramTitle
    case branchesOfChemistryTitle
    case chemistryLawsTitle
    case startReadingTitle
    case chapterAttributeTitle
    case chaptersAttributeTitle
    case sectionsAttributeTitle
    case lessonAttributeTitle
    case lessonsAttributeTitle
    case timeAttributeTitle
    case classProgramAttributeTitle
    case newsChemistryTitle
    case radiationTitle
    case theoreticalElementTitle
    case overviewTitle
    case natureTitle
    case atomParametersTitle
    case englishNameTitle
    case descriptionTitle
    case periodTitle
    case groupTitle
    case discoveredByTitle
    case namedByTitle
    case structureTitle
    case standardStateTitle
    case atomicMassTitle
    case densityTitle
    case meltTitle
    case boilTitle
    case molarHeatTitle
    case electronConfigurationTitle
    case chemotherapyTitle
    case spectralTitle
    case electronAffinityTitle
    case electronegativityTitle
    case ionizationEnergiesTitle
    case chemistryTablesTitle
    case noReactionTitle
    // MARK: - Element Group
    case allElementTitle
    case diatomicNonMetalTitle
    case polyatomicNonMetalTitle
    case alkaliTitle
    case alkaliEarthTitle
    case transitionMetalTitle
    case postTransitionMetalTitle
    case metalloidTitle
    case halogenTitle
    case nobleTitle
    case lanthanoidTitle
    case actinideTitle

    // MARK: - Solubility Category
    case soluble
    case insoluble
    case slightlySoluble
    case decomposesInWater
    case unavailableSoluble
    case voltageTitle

    // MARK: - NavigationTitle
    case periodicTableTitle
    case electrochemicalSeriesTitle
    case solubilityTableTitle
    case alkanePropertiesTitle
    case hydrocarbonChainTitle
    case experimentVideoTitle

    var localizedString: String {
        return rawValue.localizedString
    }
}
