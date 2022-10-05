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
        BoardingModel(image: "", title: "Title test", description: "Le lorem ipsum est, en imprimerie, une suite", bgColor: Color.red),
        BoardingModel(image: "", title: "Title test", description: "Le lorem ipsum est, en imprimerie, une suite", bgColor: Color.green),
        BoardingModel(image: "", title: "Title test", description: "Le lorem ipsum est, en imprimerie, une suite", bgColor: Color.purple)
    ]
}
