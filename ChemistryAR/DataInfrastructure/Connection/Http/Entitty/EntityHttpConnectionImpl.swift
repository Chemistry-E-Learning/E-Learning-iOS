//
//  EntityHttpConnectionImpl.swift
//  ChemistryAR
//
//  Created by NhatMinh on 24/11/2022.
//

import Combine
import Foundation

final class EntityHttpConnectionImpl: EntityRepository {
    func doGetEntityDetail(entityID: String) -> AnyPublisher<Element3DModel, NetworkError> {
        let apiClient = NetworkService()
        let urlString = String(format: ServerConstant.APIURL.entityDetail, entityID)
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
                decodable: ModelHttpEntity.self
            )
            .map { ModelHttpMapper.map(entity: $0) }
        return request.eraseToAnyPublisher()
    }
}
