//
//  ElementRepository.swift
//  ChemistryAR
//
//  Created by NhatMinh on 15/11/2022.
//

import Combine

protocol ElementRepository {
    func doGetElementDetail(request: ElementRequest) -> AnyPublisher<ElementDetail, NetworkError>
}
