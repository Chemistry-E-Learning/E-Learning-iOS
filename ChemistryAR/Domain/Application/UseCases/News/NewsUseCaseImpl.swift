//
//  NewsUseCaseImpl.swift
//  ChemistryAR
//
//  Created by NhatMinh on 05/12/2022.
//

import Combine
final class NewsUseCaseImpl: NewsUseCase {
    private let newsRepository = DIContainer.shared.getNewsRepository()

    func doGetNewsDetail(newsID: String) -> AnyPublisher<CarouselViewEntity, NetworkError> {
        newsRepository.doGetNewsDetail(newsID: newsID)
    }
}

