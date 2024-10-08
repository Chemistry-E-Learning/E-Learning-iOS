//
//  VideoDetailViewModelTests.swift
//  ChemistryARTests
//
//  Created by NhatMinh on 12/12/2022.
//

import Foundation
import XCTest

@testable import ChemistryAR

class VideoDetailViewModelTests: XCTestCase {
    func test_getVideoDetail_success() {
        let useCase = LessonUseCaseTest()
        let viewModel = LessonDetailViewModel(lessonID: "lessonID", useCase: useCase)
        let detailLesson = Lesson.emptyData
        useCase.result = .success(detailLesson)
        viewModel.doGetLessonDetail(id: "lessonID")
        let expectation = XCTestExpectation()
        XCTAssertTrue(viewModel.isLoading)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertNotNil(viewModel.lesson)
            XCTAssertFalse(viewModel.isLoading)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }

    func test_getVideoDetail_fail() {
        let useCase = LessonUseCaseTest()
        let viewModel = LessonDetailViewModel(lessonID: "lessonID", useCase: useCase)
        let detailLesson = Lesson.emptyData
        useCase.result = .failure(
            NetworkError(
                initialError: .sessionDeinitialized,
                backendError: nil
            )
        )
        viewModel.doGetLessonDetail(id: "lessonID")
        let expectation = XCTestExpectation()
        XCTAssertTrue(viewModel.isLoading)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertFalse(viewModel.isLoading)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }

    func test_getVideoDetail_empty() {
        let useCase = LessonUseCaseTest()
        let viewModel = LessonDetailViewModel(lessonID: "lessonID", useCase: useCase)
        let detailLesson = Lesson.emptyData
        useCase.result = .success(detailLesson)
        viewModel.doGetLessonDetail(id: "lessonID")
        let expectation = XCTestExpectation()
        XCTAssertTrue(viewModel.isLoading)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertNotNil(viewModel.lesson)
            XCTAssertFalse(viewModel.isLoading)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
}

