//
//  SeriesHttpConnectionImpl.swift
//  ChemistryAR
//
//  Created by NhatMinh on 14/11/2022.
//

import Combine
import Foundation

final class SeriesHttpConnectionImpl: SeriesRepository {
    func doGetSeriesDetail(request: SeriesRequest) -> AnyPublisher<CommonEntity<Series>, NetworkError> {
        let apiClient = NetworkService()
        let urlString = String(format: ServerConstant.APIURL.seriesDetail, request.id)
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
                decodable: CommonHttpEntity<SeriesHttpEntity>.self
            )
            .map { SeriesHttpMapper.map(entities: $0) }
        return request.eraseToAnyPublisher()
    }

    func doGetSeriesList() -> AnyPublisher<SeriesList, NetworkError> {
        let apiClient = NetworkService()
        let urlString = ServerConstant.APIURL.mainSeries
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
                decodable: SeriesListHttpEntity.self
            )
            .map { SeriesListHttpMapper.map(entity: $0) }
        return request.eraseToAnyPublisher()
    }
}
