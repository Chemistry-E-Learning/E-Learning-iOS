//
//  ElementTrackingViewModel.swift
//  ChemistryAR
//
//  Created by NhatMinh on 08/11/2022.
//

import Combine
import Foundation

final class ElementTrackingViewModel: ObservableObject {
    @Published var currentElement: Element?
    @Published var properties: [Property]?
    @Published var isLoading = false
    @Published var isShowError = false
    @Published var result = ""

    private var disposables = Set<AnyCancellable>()
    init() {
    }
}

// MARK: - API Function
extension ElementTrackingViewModel {
    // Call when new image reference is tracking
    func doGetElementInformation(with name: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.currentElement = AppConstant.elements.first { element in
                element.name.lowercased() == name
            }
            self?.doGetElementProperties()
        }
    }

    func doPredictChemicalReaction(with reactants: [String]) {
        result = "3Fe + 2O₂ → Fe₃O₄↓ ; heat"
    }
}

private extension ElementTrackingViewModel {
    func doGetElementProperties() {
        if let element = currentElement {
            properties = [
                Property(key: "Standard State", value: element.phase.rawValue),
                Property(key: "Atomic Mass", value: "\(element.atomicMass) u"),
                Property(key: "Electron Configuration", value: element.electronConfiguration),
                Property(key: "Electronegativity", value: "\(String.convertDoubleToString(item: element.electronegativityPauling))"),
                Property(key: "Element Group", value: element.category),
                Property(key: "Ionization Energy", value: "\(String.convertDoubleToString(item: element.ionizationEnergies.first)) eV"),
                Property(key: "Electron Affinity", value: "\(String.convertDoubleToString(item: element.electronAffinity)) eV"),
                Property(key: "Melting Point", value: "\(String.convertDoubleToString(item: element.melt)) K"),
                Property(key: "Molar Heat", value: "\(String.convertDoubleToString(item: element.molarHeat)) K"),
                Property(key: "Boiling Point", value: "\(String.convertDoubleToString(item: element.boil)) K"),
                Property(key: "Density", value: "\(String.convertDoubleToString(item: element.density)) g/cm³"),
                Property(key: "Named By", value: element.namedBy ?? AppConstant.NoContent),
                Property(key: "Discovered By", value: element.discoveredBy ?? AppConstant.NoContent)
            ]
        }
    }
}
