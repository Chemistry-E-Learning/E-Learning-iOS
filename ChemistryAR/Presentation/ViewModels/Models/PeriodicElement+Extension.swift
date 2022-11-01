//
//  PeriodicElement+Extension.swift
//  periodic-table
//
//  Created by Imran Mohammed on 12/02/20.
//  Copyright © 2020 Able. All rights reserved.
//

import Foundation
import SwiftUI

extension PeriodicElementList {
    func periodicElementMatrix() -> Matrix<Element> {
        var elementMatrix: Matrix<Element> = Matrix(rows: 10, columns: 18, defaultValue: Element.emptyElement)
        for e in elements {
            elementMatrix[e.ypos - 1 ,e.xpos - 1] = e
        } 
        return elementMatrix
    }
}

extension Element {
    func isValid() -> Bool {
        return !(name.isEmpty || symbol.isEmpty)
    }

    func getColor() -> Color {
        switch getGroup() {
        case .diatomicNonMetal:
            return .diatomicNonMetal
        case .polyatomicNonMetal:
            return .polyatomicNonMetal
        case .alkali:
            return .alkali
        case .alkaliEarth:
            return .alkaliEarth
        case .transitionMetal:
            return .transitionMetal
        case .postTransitionMetal:
            return .postTransitionMetal
        case .metalloid:
            return .metalloid
        case .halogen:
            return .halogen
        case .noble:
            return .noble
        case .lanthanoid:
            return .lanthanoid
        case .actinide:
            return .actinide
        default:
            return .clear
        }
    }

    func getGroup() -> ElementGroup {
        switch number {
        case 1, 6, 15, 16, 34:
            return .polyatomicNonMetal
        case 7, 8:
            return .diatomicNonMetal
        case 3, 11, 19, 37, 55, 87:
            return .alkali
        case 4, 12, 20, 38, 56, 88:
            return .alkaliEarth
        case 21, 22,23, 24, 25, 26, 27, 28, 29, 30, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 72, 73, 74, 75, 76, 77, 78, 79, 80, 104, 105, 106, 107, 108, 109, 110, 111, 112:
            return .transitionMetal
        case 13, 31, 49, 50, 81, 82, 83, 113, 114, 115, 116:
            return .postTransitionMetal
        case 5, 14, 32, 33, 51, 52, 84:
            return .metalloid
        case 9, 17, 35, 53, 85, 117:
            return .halogen
        case 2, 10, 18, 36, 54, 86, 118:
            return .noble
        case 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71:
            return .lanthanoid
        case 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103:
            return .actinide
        default:
            return .initial
        }
    }
}

enum ElementGroup: Hashable {
    case initial
    case diatomicNonMetal
    case polyatomicNonMetal
    case alkali
    case alkaliEarth
    case transitionMetal
    case postTransitionMetal
    case metalloid
    case halogen
    case noble
    case lanthanoid
    case actinide

    func getColor() -> Color {
        switch self {
        case .initial:
            return Color.red.opacity(0.7)
        case .diatomicNonMetal:
            return .diatomicNonMetal
        case .polyatomicNonMetal:
            return .polyatomicNonMetal
        case .alkali:
            return .alkali
        case .alkaliEarth:
            return .alkaliEarth
        case .transitionMetal:
            return .transitionMetal
        case .postTransitionMetal:
            return .postTransitionMetal
        case .metalloid:
            return .metalloid
        case .halogen:
            return .halogen
        case .noble:
            return .noble
        case .lanthanoid:
            return .lanthanoid
        case .actinide:
            return .actinide
        }
    }

    func getGroupName() -> String {
        switch self {
        case .initial:
            return Localization.allElementTitle.localizedString
        case .diatomicNonMetal:
            return Localization.diatomicNonMetalTitle.localizedString
        case .polyatomicNonMetal:
            return Localization.polyatomicNonMetalTitle.localizedString
        case .alkali:
            return Localization.alkaliTitle.localizedString
        case .alkaliEarth:
            return Localization.alkaliEarthTitle.localizedString
        case .transitionMetal:
            return Localization.transitionMetalTitle.localizedString
        case .postTransitionMetal:
            return Localization.postTransitionMetalTitle.localizedString
        case .metalloid:
            return Localization.metalloidTitle.localizedString
        case .halogen:
            return Localization.halogenTitle.localizedString
        case .noble:
            return Localization.nobleTitle.localizedString
        case .lanthanoid:
            return Localization.lanthanoidTitle.localizedString
        case .actinide:
            return Localization.actinideTitle.localizedString
        }
    }
}
