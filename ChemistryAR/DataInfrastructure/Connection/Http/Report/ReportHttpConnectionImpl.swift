//
//  ReportHttpConnectionImpl.swift
//  ChemistryAR
//
//  Created by NhatMinh on 07/12/2022.
//

import Combine
import Foundation

final class ReportHttpConnectionImpl: ReportRepository {
    func doSendReportContent(report: ReportModel) -> AnyPublisher<ReportEntity, NetworkError> {
        let apiClient = NetworkService()
        let urlString = String(format: ServerConstant.APIURL.report)
        guard let url = URL(string: urlString) else {
            return Fail(
                error: NetworkError(
                    initialError: .invalidURL(url: urlString),
                    backendError: nil
                )
            )
            .eraseToAnyPublisher()
        }
        let requestInfo = RequestInfo(url: url, method: .post)
        let request = apiClient
            .requestAPI(
                info: requestInfo,
                parameters: report,
                decodable: ReportEntity.self
            )
        return request.eraseToAnyPublisher()
    }
}
