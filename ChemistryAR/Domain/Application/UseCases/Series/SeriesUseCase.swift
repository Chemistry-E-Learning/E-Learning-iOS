//
//  SeriesUseCase.swift
//  ChemistryAR
//
//  Created by NhatMinh on 14/11/2022.
//

import Combine

protocol SeriesUseCase {
    func doGetSeriesDetail(request: SeriesRequest) -> AnyPublisher<CommonEntity<Series>, NetworkError>
    func doGetSeriesList() -> AnyPublisher<SeriesList, NetworkError>
}
