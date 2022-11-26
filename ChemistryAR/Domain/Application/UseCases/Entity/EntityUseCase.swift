//
//  EntityUseCase.swift
//  ChemistryAR
//
//  Created by NhatMinh on 24/11/2022.
//

import Combine

protocol EntityUseCase {
    func doGetEntityDetail(entityID: String) -> AnyPublisher<Element3DModel, NetworkError>
}
