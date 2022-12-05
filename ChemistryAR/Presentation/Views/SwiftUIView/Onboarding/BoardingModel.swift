//
//  BoardingModel.swift
//  ChemistryAR
//
//  Created by NhatMinh on 04/10/2022.
//

import Foundation
import SwiftUI

struct BoardingModel: Identifiable {
    var id = UUID().uuidString
    var image: String
    var title: String
    var description: String
    var bgColor: Color

    static let screens = [
        BoardingModel(
            image: "onboarding-first",
            title: Localization.arTitle.localizedString,
            description: Localization.arDesc.localizedString,
            bgColor: Color(hex: 0x7D5ACE)
        ),
        BoardingModel(
            image: "onboarding-second",
            title: Localization.experimentPracticeTitle.localizedString,
            description: Localization.experimentPracticeDesc.localizedString,
            bgColor: Color(hex: 0x6691D2)
        ),
        BoardingModel(
            image: "onboarding-last",
            title: Localization.additionalKnowledgeTitle.localizedString,
            description: Localization.additionalKnowledgeDesc.localizedString,
            bgColor: Color(hex: 0x00A899)
        )
    ]
}
