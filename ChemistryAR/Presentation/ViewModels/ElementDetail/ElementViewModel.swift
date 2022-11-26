//
//  ElementDetailViewModel.swift
//  ChemistryAR
//
//  Created by NhatMinh on 15/11/2022.
//

import Combine
import Foundation

final class ElementViewModel: ObservableObject {
    @Published var element = ElementDetail.emptyData
    @Published var overview = OverviewModel.emptyData
    @Published var nature = NatureModel.emptyData
    @Published var models: [Element3DModel]?
    @Published var atomParameters = AtomParameter.emptyData
    @Published var isShowWikipediaView = false
    @Published var isLoading = true
    @Published var isShowError = false
    @Published var isShowARCamera = false

    private(set) var wikipediaURL = ""
    private let elementUseCase: ElementUseCase
    private var disposables = Set<AnyCancellable>()

    init(
        elementID: String,
        useCase: ElementUseCase = DIContainer.shared.getElementUseCase()
    ) {
        elementUseCase = useCase
        doGetElementDetail(id: elementID)
    }
}

// MARK: - API Function
extension ElementViewModel {
    func doGetElementDetail(id: String) {
        elementUseCase.doGetElementDetail(request: ElementRequest(id: id))
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
                self.element = response
                print("MinhNN44 - \(response.name)")
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
                self.models = response.models
            }
            .store(in: &disposables)
    }
}

// MARK: - Function
extension ElementViewModel {
    func onClickWikipediaButton() {
        isShowWikipediaView = true
    }
    
    func onClickCameraButton() {
        isShowARCamera.toggle()
    }
}
