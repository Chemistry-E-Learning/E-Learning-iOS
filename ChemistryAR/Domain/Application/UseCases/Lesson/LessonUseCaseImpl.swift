//
//  LessonUseCaseImpl.swift
//  ChemistryAR
//
//  Created by NhatMinh on 16/11/2022.
//

import Combine

final class LessonUseCaseImpl: LessonUseCase {
    private let lessonRepository = DIContainer.shared.getLessonRepository()

    func doGetLessonDetail(lessonID: String) -> AnyPublisher<Lesson, NetworkError> {
        return lessonRepository.doGetLessonDetail(lessonID: lessonID)
    }

    func doGetLessonsList(seriesID: String) -> AnyPublisher<CommonEntity<Lesson>, NetworkError> {
        return lessonRepository.doGetLessonsList(seriesID: seriesID)
    }
}
