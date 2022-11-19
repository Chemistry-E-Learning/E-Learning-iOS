//
//  ReactionUseCase.swift
//  ChemistryAR
//
//  Created by NhatMinh on 15/11/2022.
//

import Combine

protocol ReactionUseCase {
    func doGetReactionResult(param: ReactionRequest) -> AnyPublisher<Reaction, NetworkError>
    func doGetChemicalsList() -> AnyPublisher<ChemicalsList, NetworkError>
}
