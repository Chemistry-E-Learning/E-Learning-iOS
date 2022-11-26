//
//  ChemistryBookViewModel.swift
//  ChemistryAR
//
//  Created by NhatMinh on 24/11/2022.
//

import Combine
import Foundation

final class ChemistryBookTrackingViewModel: ObservableObject {
    @Published var currentModel: Element3DModel?
    @Published var modelCache = [Element3DModel]()
    @Published var isLoading = true
    @Published var isShowError = false

    private let entityUseCase: EntityUseCase
    private var disposables = Set<AnyCancellable>()
    init(useCase: EntityUseCase = DIContainer.shared.getEntityUseCase()) {
        entityUseCase = useCase
    }
}

// MARK: - API Function
extension ChemistryBookTrackingViewModel {
    func doGetEntityDetail(with entityID: String) {
        entityUseCase.doGetEntityDetail(entityID: entityID)
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
                self.currentModel = response
                print("Minh Res - \(response.name)")
                if !self.modelCache.contains(where: { model in
                    model.name == response.name
                }) {
                    self.modelCache.append(response)
                }
            }
            .store(in: &disposables)
    }
}
