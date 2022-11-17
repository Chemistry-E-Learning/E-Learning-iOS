//
//  ElementUseCaseImpl.swift
//  ChemistryAR
//
//  Created by NhatMinh on 15/11/2022.
//

import Combine

final class ElementUseCaseImpl: ElementUseCase {
    private let elementRepository = DIContainer.shared.getElementRepository()

    func doGetElementDetail(request: ElementRequest) -> AnyPublisher<ElementDetail, NetworkError> {
        return elementRepository.doGetElementDetail(request: request)
    }
}
