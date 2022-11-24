//
//  PeriodicTableViewModel.swift
//  ChemistryAR
//
//  Created by NhatMinh on 23/11/2022.
//

import Foundation

final class PeriodicTableViewModel: ObservableObject {
    @Published var isPushToElementDetailView = false
    private(set) var elementID = ""

    init() {
    }

    func onClickElementItem(id: String) {
        elementID = id
        isPushToElementDetailView = true
    }
}
