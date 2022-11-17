//
//  SeriesUseCaseImpl.swift
//  ChemistryAR
//
//  Created by NhatMinh on 14/11/2022.
//

import Combine

final class SeriesUseCaseImpl: SeriesUseCase {
    private let seriesRepository = DIContainer.shared.getSeriesRepository()

    func doGetSeriesDetail(request: SeriesRequest) -> AnyPublisher<CommonEntity<Series>, NetworkError> {
        return seriesRepository.doGetSeriesDetail(request: request)
    }
    func doGetSeriesList() -> AnyPublisher<SeriesList, NetworkError> {
        return seriesRepository.doGetSeriesList()
    }
}
