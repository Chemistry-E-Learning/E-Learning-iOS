//
//  ReactionUseCaseImpl.swift
//  ChemistryAR
//
//  Created by NhatMinh on 15/11/2022.
//

import Combine

final class ReactionUseCaseImpl: ReactionUseCase {
    private let reactionRepository = DIContainer.shared.getReactionRepository()

    func doGetReactionResult(param: ReactionRequest) -> AnyPublisher<Reaction, NetworkError> {
        return reactionRepository.doGetReactionResult(param: param)
    }
    func doGetChemicalsList() -> AnyPublisher<ChemicalsList, NetworkError> {
        return reactionRepository.doGetChemicalsList()
    }
}
