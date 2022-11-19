//
//  ReactionHttpConnectionImpl.swift
//  ChemistryAR
//
//  Created by NhatMinh on 15/11/2022.
//

import Combine
import Foundation

final class ReactionHttpConnectionImpl: ReactionRepository {
    func doGetReactionResult(param: ReactionRequest) -> AnyPublisher<Reaction, NetworkError> {
        let apiClient = NetworkService()
        let urlString = String(format: ServerConstant.APIURL.predictReaction)
        guard let url = URL(string: urlString) else {
            return Fail(
                error: NetworkError(
                    initialError: .invalidURL(url: urlString),
                    backendError: nil
                )
            )
                .eraseToAnyPublisher()
        }
        let requestInfo = RequestInfo(url: url, method: .get)
        let request = apiClient
            .requestAPI(
                info: requestInfo,
                parameters: param,
                decodable: ReactionHttpEntity.self
            )
            .map { ReactionHttpMapper.map(entity: $0) }
        return request.eraseToAnyPublisher()
    }

    func doGetChemicalsList() -> AnyPublisher<ChemicalsList, NetworkError> {
        let apiClient = NetworkService()
        let urlString = String(format: ServerConstant.APIURL.chemicalsList)
        guard let url = URL(string: urlString) else {
            return Fail(
                error: NetworkError(
                    initialError: .invalidURL(url: urlString),
                    backendError: nil
                )
            )
                .eraseToAnyPublisher()
        }
        let requestInfo = RequestInfo(url: url, method: .get)
        let request = apiClient
            .requestAPI(
                info: requestInfo,
                parameters: EmptyRequest(),
                decodable: ChemicalsListHttpEntity.self
            )
            .map { ChemicalHttpMapper.map(entity: $0) }
        return request.eraseToAnyPublisher()
    }
}
