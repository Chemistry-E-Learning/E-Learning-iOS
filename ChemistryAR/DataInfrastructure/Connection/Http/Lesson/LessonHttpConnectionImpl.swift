//
//  LessonHttpConnectionImpl.swift
//  ChemistryAR
//
//  Created by NhatMinh on 16/11/2022.
//

import Combine
import Foundation

final class LessonHttpConnectionImpl: LessonRepository {
    func doGetLessonDetail(lessonID: String) -> AnyPublisher<Lesson, NetworkError> {
        let apiClient = NetworkService()
        let urlString = String(format: ServerConstant.APIURL.lessonDetail, lessonID)
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
                decodable: LessonHttpEntity.self
            )
            .map { LessonHttpMapper.map(entity: $0) }
        return request.eraseToAnyPublisher()
    }

    func doGetLessonsList(seriesID: String) -> AnyPublisher<CommonEntity<Lesson>, NetworkError> {
        let apiClient = NetworkService()
        let urlString = String(format: ServerConstant.APIURL.lessonsList, seriesID)
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
                decodable: CommonHttpEntity<LessonHttpEntity>.self
            )
            .map { LessonHttpMapper.map(entities: $0) }
        return request.eraseToAnyPublisher()
    }

}
