//
//  LessonViewModel.swift
//  ChemistryAR
//
//  Created by NhatMinh on 16/11/2022.
//

import Combine
import Foundation

final class LessonsListViewModel: ObservableObject {
    @Published var lessons = [Lesson](repeating: Lesson.emptyData, count: 6)
    @Published var series = Series.emptyData
    @Published var isPushToLessonDetailView = false
    @Published var isLoading = true
    @Published var isShowError = false
    @Published var videoNumber = 0
    @Published var durationTotal = 0
    private(set) var lessonID = ""
    private(set) var lessonNumber = 0

    private let lessonUseCase: LessonUseCase
    private var disposables = Set<AnyCancellable>()

    init(
        seriesID: String,
        useCase: LessonUseCase = DIContainer.shared.getLessonUseCase()
    ) {
        lessonUseCase = useCase
        doGetLessonsList(id: seriesID)
    }
}

// MARK: - API Function
extension LessonsListViewModel {
    func doGetLessonsList(id: String) {
        lessonUseCase.doGetLessonsList(seriesID: id)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                guard let self = self else { return }
                switch error {
                case .failure:
                    self.isShowError = true
                case .finished:
                    break
                }
                self.isLoading = false
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.lessons = response.contents
                self.series = response.contents.first?.series ?? Series.emptyData
                self.getVideoNumber()
                self.getDurationTotal()
            }
            .store(in: &disposables)
    }
}

// MARK: - Helper Function
private extension LessonsListViewModel {
    func getVideoNumber() {
        lessons.forEach { lesson in
            if let videoURL = lesson.videoURL, !videoURL.isEmpty {
                videoNumber += 1
            }
        }
    }

    func getDurationTotal() {
        lessons.forEach { lesson in
            if let duration = lesson.duration {
                durationTotal += duration
            }
        }
    }
}

// MARK: - Function View
extension LessonsListViewModel {
    func onClickLessonItemView(id: String, index: Int) {
        lessonID = id
        lessonNumber = index
        isPushToLessonDetailView = true
    }
}
