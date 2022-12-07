//
//  ReportUseCaseImpl.swift
//  ChemistryAR
//
//  Created by NhatMinh on 07/12/2022.
//

import Combine
final class ReportUseCaseImpl: ReportUseCase {
    private let reportRepository = DIContainer.shared.getReportRepository()

    func doSendReportContent(report: ReportModel) -> AnyPublisher<ReportEntity, NetworkError> {
        reportRepository.doSendReportContent(report: report)
    }
}
