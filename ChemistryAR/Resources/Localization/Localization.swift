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

    var localizedString: String {
        return rawValue.localizedString
    }
}
