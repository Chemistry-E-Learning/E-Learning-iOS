//
//  LessonDetailViewModel.swift
//  ChemistryAR
//
//  Created by NhatMinh on 16/11/2022.
//

import AVKit
import Combine
import Foundation

final class LessonDetailViewModel: ObservableObject {
    @Published var lesson = Lesson.emptyData
    @Published var isLoading = true
    @Published var isShowError = false
    @Published var avPlayer: AVPlayer?

    private let lessonUseCase: LessonUseCase
    private var disposables = Set<AnyCancellable>()

    init(
        lessonID: String,
        useCase: LessonUseCase = DIContainer.shared.getLessonUseCase()
    ) {
        lessonUseCase = useCase
        doGetLessonDetail(id: lessonID)
    }
}

// MARK: - API Function
extension LessonDetailViewModel {
    func doGetLessonDetail(id: String) {
        lessonUseCase.doGetLessonDetail(lessonID: id)
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
                self.lesson = response
                if let videoURL = response.videoURL, let url = URL(string: videoURL) {
                    self.avPlayer = AVPlayer(url: url)
                }
            }
            .store(in: &disposables)
    }
}
