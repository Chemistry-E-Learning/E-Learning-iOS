//
//  LessonRepository.swift
//  ChemistryAR
//
//  Created by NhatMinh on 16/11/2022.
//

import Combine

protocol LessonRepository {
    func doGetLessonDetail(lessonID: String) -> AnyPublisher<Lesson, NetworkError>
    func doGetLessonsList(seriesID: String) -> AnyPublisher<CommonEntity<Lesson>, NetworkError>
}
