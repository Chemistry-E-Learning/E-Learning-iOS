//
//  ReportUseCase.swift
//  ChemistryAR
//
//  Created by NhatMinh on 07/12/2022.
//

import Combine

protocol ReportUseCase {
    func doSendReportContent(report: ReportModel) -> AnyPublisher<ReportEntity, NetworkError>
}

struct ReportEntity: Codable {
    let id: String?
}
