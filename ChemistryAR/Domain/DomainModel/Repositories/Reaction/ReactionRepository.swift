//
//  ReactionRepository.swift
//  ChemistryAR
//
//  Created by NhatMinh on 15/11/2022.
//

import Combine

protocol ReactionRepository {
    func doGetReactionResult(param: ReactionRequest) -> AnyPublisher<Reaction, NetworkError>
}
