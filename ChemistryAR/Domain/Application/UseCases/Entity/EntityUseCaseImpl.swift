//
//  EntityUseCaseImpl.swift
//  ChemistryAR
//
//  Created by NhatMinh on 24/11/2022.
//

import Combine

final class EntityUseCaseImpl: EntityUseCase {
    private let entityRepository = DIContainer.shared.getEntityRepository()

    func doGetEntityDetail(entityID: String) -> AnyPublisher<Element3DModel, NetworkError> {
        return entityRepository.doGetEntityDetail(entityID: entityID)
    }
}
