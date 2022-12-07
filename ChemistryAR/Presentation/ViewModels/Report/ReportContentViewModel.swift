//
//  ReportContentViewModel.swift
//  ChemistryAR
//
//  Created by NhatMinh on 07/12/2022.
//

import Combine
import Foundation
import SwiftUI

final class ReportContentViewModel: ObservableObject {
    @Published var isSuccess = false
    @Published var isShowError = false
    @Published var isShowReportView = true

    private let reportUseCase: ReportUseCase
    private var disposables = Set<AnyCancellable>()
    init(
        useCase: ReportUseCase = DIContainer.shared.getReportUseCase()
    ) {
        reportUseCase = useCase
    }
}

// MARK: - API Function
extension ReportContentViewModel {
    func doSendReport(with report: ReportModel) {
        reportUseCase.doSendReportContent(report: report)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                guard let self = self else { return }
                switch error {
                case .failure:
                    self.isShowError = true
                    self.isShowReportView = false
                case .finished:
                    break
                }
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.isSuccess = true
                self.isShowReportView = false
            }
            .store(in: &disposables)
    }
}

struct ReportRequest: Codable {
    let report: ReportModel
}

struct ReportModel: Codable {
    let username: String
    let contentID: String
    let contentName: String
    let message: String
}
