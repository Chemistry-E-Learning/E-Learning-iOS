//
//  ElementHttpConnectionImpl.swift
//  ChemistryAR
//
//  Created by NhatMinh on 15/11/2022.
//

import Combine
import Foundation

final class ElementHttpConnectionImpl: ElementRepository {
    func doGetElementDetail(request: ElementRequest) -> AnyPublisher<ElementDetail, NetworkError> {
        let apiClient = NetworkService()
        let urlString = String(format: ServerConstant.APIURL.elementDetail, request.id)
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
                parameters: request,
                decodable: ElementHttpEntity.self
            )
            .map { ElementHttpMapper.map(entity: $0) }
        return request.eraseToAnyPublisher()
    }
}
