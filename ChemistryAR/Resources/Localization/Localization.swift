//
//  Localization.swift
//  ChemistryAR
//
//  Created by NhatMinh on 17/09/2022.
//

import Foundation

enum Localization: String {
    case classProgramTitle
    case branchesOfChemistryTitle
    case chemistryLawsTitle
    case helloTitle
    case welcomeBackTitle
    case startCourseTitle

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

    var localizedString: String {
        return rawValue.localizedString
    }
}
