//
//  ReportRepository.swift
//  ChemistryAR
//
//  Created by NhatMinh on 07/12/2022.
//


import Combine

protocol ReportRepository {
    func doSendReportContent(report: ReportModel) -> AnyPublisher<ReportEntity, NetworkError>
}
