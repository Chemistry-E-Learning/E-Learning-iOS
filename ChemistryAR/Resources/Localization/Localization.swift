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
    case classProgramAttributeTitle

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

    // MARK: - NavigationTitle
    case periodicTableTitle
    case electrochemicalSeriesTitle
    case solubilityTableTitle
    case experimentVideoTitle

    var localizedString: String {
        return rawValue.localizedString
    }
}
