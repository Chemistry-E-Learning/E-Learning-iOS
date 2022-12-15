//
//  ElementCardTrackingViewModelTests.swift
//  ChemistryARTests
//
//  Created by NhatMinh on 12/12/2022.
//

import Foundation
import XCTest

@testable import ChemistryAR

class ElementCardTrackingViewModelTests: XCTestCase {
    func test_getElementInformation_success() {
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

    func test_getElementInformation_fail() {
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

    func test_getElementInformation_empty() {
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

    func test_getReaction_empty() {
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

    func test_getReaction_fail() {
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

    func test_getReaction_success() {
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
