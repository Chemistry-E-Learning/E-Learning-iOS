//
//  HomeViewModel.swift
//  ChemistryAR
//
//  Created by NhatMinh on 14/11/2022.
//

import Combine
import Foundation

final class HomeViewModel: ObservableObject {
    @Published var programSeries = [Series](repeating: Series.emptyData, count: 5)
    @Published var branchSeries = AppConstant.branchesDummyData
    @Published var chemistryNews = [CarouselViewEntity](repeating: CarouselViewEntity.emptyData, count: 9)
    @Published var lawSeries = [Series](repeating: Series.emptyData, count: 9)
    @Published var isPushToChaptersListView = false
    @Published var isPushToBranchesView = false
    @Published var isPushToLawsView = false
    @Published var isPushToNewsDetailView = false
    @Published var isPushToUserSettingView = false
    @Published var isLoading = true
    @Published var isShowError = false
    private(set) var seriesID = ""
    private(set) var newsID = ""
    private(set) var program = Series.emptyData
    private(set) var videoNumber = 32


    private let seriesUseCase: SeriesUseCase
    private var disposables = Set<AnyCancellable>()

    init(
        useCase: SeriesUseCase = DIContainer.shared.getSeriesUseCase()
    ) {
        seriesUseCase = useCase
        doGetSeriesList()
    }
}

// MARK: - API Function
extension HomeViewModel {
    func doGetSeriesList() {
        seriesUseCase.doGetSeriesList()
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
                self.programSeries = response.programSeries.contents
                self.branchSeries = response.branchSeries.contents
                self.chemistryNews = response.chemistryNews.contents
                self.lawSeries = response.lawSeries.contents
            }
            .store(in: &disposables)
    }

    func logGA4EventSelectNews(news: CarouselViewEntity) {
        GA4Manager.shared.trackCustomEvent(
            eventName: .selectContent,
            parameters: [
                GA4ParameterKey.contentType.key: GA4ParameterValue.news.value,
                GA4ParameterKey.itemID.key: news.id,
                GA4ParameterKey.newsName.key: news.title
            ]
        )
    }
}

// MARK: - Function
extension HomeViewModel {
    func onClickProgramItemView(program: Series, videosNumber: Int) {
        isPushToChaptersListView = true
        self.program = program
        self.videoNumber = videosNumber
    }

    func onClickBranchItemView(id: String) {
        isPushToBranchesView = true
        seriesID = id
    }

    func onClickLawItemView(id: String) {
        isPushToLawsView = true
        seriesID = id
    }

    func onClickNewsItemView(id: String) {
        newsID = id
        isPushToNewsDetailView = true
    }
}
