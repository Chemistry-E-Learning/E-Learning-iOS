//
//  CarouselsViewModel.swift
//  ChemistryAR
//
//  Created by NhatMinh on 05/12/2022.
//

import Combine
import Foundation

final class CarouselsViewModel: ObservableObject {
    @Published var news = CarouselViewEntity.emptyData
    @Published var isLoading = true
    @Published var isShowError = false

    private let newsUseCase: NewsUseCase
    private var disposables = Set<AnyCancellable>()
    init(
        id: String,
        useCase: NewsUseCase = DIContainer.shared.getNewsUseCase()
    ) {
        newsUseCase = useCase
        doGetNewsDetail(with: id)
    }
}

// MARK: - API Function
extension CarouselsViewModel {
    func doGetNewsDetail(with id: String) {
        newsUseCase.doGetNewsDetail(newsID: id)
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
                self.news = response
            }
            .store(in: &disposables)
    }
}
