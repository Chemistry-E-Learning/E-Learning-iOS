//
//  NewsRepository.swift
//  ChemistryAR
//
//  Created by NhatMinh on 05/12/2022.
//

import Combine

protocol NewsRepository {
    func doGetNewsDetail(newsID: String) -> AnyPublisher<CarouselViewEntity, NetworkError>
}
