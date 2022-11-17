//
//  ElementTrackingViewModel.swift
//  ChemistryAR
//
//  Created by NhatMinh on 08/11/2022.
//

import Combine
import Foundation

final class ImageTrackingViewModel: ObservableObject {
    @Published var currentElement: ElementDetail?
    @Published var element = ElementDetail.emptyData
    @Published var overview = OverviewModel.emptyData
    @Published var nature = NatureModel.emptyData
    @Published var atomParameters = AtomParameter.emptyData
    @Published var properties: [Property]?
    @Published var isLoading = false
    @Published var isShowError = false
    @Published var reactants = [String]()
    @Published var chemicalEquation = [String]()

    private let elementUseCase: ElementUseCase
    private let reactionUseCase: ReactionUseCase
    private var disposables = Set<AnyCancellable>()
    init(
        elementUseCase: ElementUseCase = DIContainer.shared.getElementUseCase(),
        reactionUseCase: ReactionUseCase = DIContainer.shared.getReactionUseCase()
    ) {
        self.elementUseCase = elementUseCase
        self.reactionUseCase = reactionUseCase
    }
}

// MARK: - API Function
extension ImageTrackingViewModel {
    // Call when new image reference is tracking
    func doGetElementInformation(with name: String) {
        elementUseCase.doGetElementDetail(request: ElementRequest(id: name))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                guard let self = self else { return }
                switch error {
                case .failure:
                    self.isShowError = true
                case .finished:
                    break
                }
                self.isLoading = false
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.currentElement = response
                self.overview = OverviewModel(
                    name: response.name,
                    description: response.summary,
                    period: response.period,
                    group: response.group.getGroupName(),
                    discoveredBy: response.discoveredBy ?? AppConstant.NoContent,
                    nameBy: response.namedBy ?? AppConstant.NoContent,
                    structureImage: response.structureImage?.url
                )
                self.nature = NatureModel(
                    standardState: response.phase.rawValue,
                    atomicMass: response.atomicMass,
                    density: response.density,
                    melt: response.melt,
                    boil: response.boil,
                    molarHeat: response.molarHeat
                )
                self.atomParameters = AtomParameter(
                    electronConfiguration: response.configuration,
                    chemotherapy: response.chemotherapy ?? [],
                    spectralImage: response.spectralImage?.url,
                    electronAffinity: response.electronAffinity,
                    electronegativity: response.electronegativity,
                    ionizationEnergies: response.ionizationEnergies
                )
                self.doGetElementProperties()
            }
            .store(in: &disposables)
    }

    func doGetReactionResult(with reactants: [String]) {
        let param = ReactionRequest(reactants: reactants)
        reactionUseCase.doGetReactionResult(param: param)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                guard let self = self else { return }
                switch error {
                case .failure:
                    self.isShowError = true
                case .finished:
                    break
                }
                self.isLoading = false
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.reactants = response.reactants
                self.chemicalEquation = response.chemicalEquation
            }
            .store(in: &disposables)
    }
}

private extension ImageTrackingViewModel {
    func doGetElementProperties() {
//        if let element = currentElement {
//            properties = [
//                Property(key: "Standard State", value: element.phase.rawValue),
//                Property(key: "Atomic Mass", value: "\(element.atomicMass) u"),
//                Property(key: "Electron Configuration", value: element.electronConfiguration),
//                Property(key: "Electronegativity", value: "\(String.convertOptionalToString(item: element.electronegativityPauling))"),
//                Property(key: "Element Group", value: element.category),
//                Property(key: "Ionization Energy", value: "\(String.convertOptionalToString(item: element.ionizationEnergies.first)) eV"),
//                Property(key: "Electron Affinity", value: "\(String.convertOptionalToString(item: element.electronAffinity)) eV"),
//                Property(key: "Melting Point", value: "\(String.convertOptionalToString(item: element.melt)) K"),
//                Property(key: "Molar Heat", value: "\(String.convertOptionalToString(item: element.molarHeat)) K"),
//                Property(key: "Boiling Point", value: "\(String.convertOptionalToString(item: element.boil)) K"),
//                Property(key: "Density", value: "\(String.convertOptionalToString(item: element.density)) g/cm³"),
//                Property(key: "Named By", value: element.namedBy ?? AppConstant.NoContent),
//                Property(key: "Discovered By", value: element.discoveredBy ?? AppConstant.NoContent)
//            ]
//        }
    }
}
