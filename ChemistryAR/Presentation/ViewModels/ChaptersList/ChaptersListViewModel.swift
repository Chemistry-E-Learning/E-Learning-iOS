//
//  ChaptersListViewModel.swift
//  ChemistryAR
//
//  Created by NhatMinh on 14/11/2022.
//

import Combine
import Foundation

final class ChaptersListViewModel: ObservableObject {
    @Published var programDetailSeries = [Series](repeating: Series.emptyData, count: 6)
    @Published var isPushToVideosListView = false
    @Published var isLoading = true
    @Published var isShowError = false
    private(set) var seriesID = ""
    private(set) var chapterNumber = 0

    private let seriesUseCase: SeriesUseCase
    private var disposables = Set<AnyCancellable>()

    init(
        seriesID: String,
        useCase: SeriesUseCase = DIContainer.shared.getSeriesUseCase()
    ) {
        seriesUseCase = useCase
        doGetSeriesDetail(id: seriesID)
    }
}

// MARK: - API Function
extension ChaptersListViewModel {
    func doGetSeriesDetail(id: String) {
        seriesUseCase.doGetSeriesDetail(request: SeriesRequest(id: id))
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
                self.programDetailSeries = response.contents
            }
            .store(in: &disposables)
    }
}

// MARK: - Function
extension ChaptersListViewModel {
    func onClickChapterItemView(id: String, index: Int) {
        chapterNumber = index
        seriesID = id
        isPushToVideosListView = true
    }
}
