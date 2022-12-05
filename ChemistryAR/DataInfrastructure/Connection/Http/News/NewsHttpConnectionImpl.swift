//
//  NewsHttpConnectionImpl.swift
//  ChemistryAR
//
//  Created by NhatMinh on 05/12/2022.
//

import Combine
import Foundation

final class NewsHttpConnectionImpl: NewsRepository {
    func doGetNewsDetail(newsID: String) -> AnyPublisher<CarouselViewEntity, NetworkError> {
        let apiClient = NetworkService()
        let urlString = String(format: ServerConstant.APIURL.newsDetail, newsID)
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
                decodable: NewsHttpEntity.self
            )
            .map { NewsHttpMapper.map(entity: $0) }
        return request.eraseToAnyPublisher()
    }
}
