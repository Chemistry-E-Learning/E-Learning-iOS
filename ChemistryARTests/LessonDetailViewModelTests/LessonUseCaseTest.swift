//
//  LessonUseCaseTest.swift
//  ChemistryAR
//
//  Created by NhatMinh on 12/12/2022.
//

import Combine
@testable import ChemistryAR

class LessonUseCaseTest: LessonUseCase {
    var result: Result<Lesson, NetworkError>?
    var results: Result<CommonEntity<Lesson>, NetworkError>?

    func doGetLessonDetail(lessonID: String) -> AnyPublisher<Lesson, NetworkError> {
        if let result = result {
            switch result {
            case .success(let detailLesson):
                return Just(detailLesson)
                    .setFailureType(to: NetworkError.self)
                    .eraseToAnyPublisher()
            case .failure(let error):
                return Fail(error: error).eraseToAnyPublisher()
            }
        }
        return Fail(
            error: NetworkError(
                initialError: .sessionDeinitialized,
                backendError: nil
            )
        )
            .eraseToAnyPublisher()
    }
    func doGetLessonsList(seriesID: String) -> AnyPublisher<CommonEntity<Lesson>, NetworkError> {
        if let result = results {
            switch result {
            case .success(let lessons):
                return Just(lessons)
                    .setFailureType(to: NetworkError.self)
                    .eraseToAnyPublisher()
            case .failure(let error):
                return Fail(error: error).eraseToAnyPublisher()
            }
        }
        return Fail(
            error: NetworkError(
                initialError: .sessionDeinitialized,
                backendError: nil
            )
        )
            .eraseToAnyPublisher()
    }
}
