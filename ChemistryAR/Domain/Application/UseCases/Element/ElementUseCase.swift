//
//  ElementUseCase.swift
//  ChemistryAR
//
//  Created by NhatMinh on 15/11/2022.
//

import Combine

protocol ElementUseCase {
    func doGetElementDetail(request: ElementRequest) -> AnyPublisher<ElementDetail, NetworkError>
}
