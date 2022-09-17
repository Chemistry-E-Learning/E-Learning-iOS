//
//  NetworkService.swift
//  ChemistryAR
//
//  Created by NhatMinh on 17/09/2022.
//

import Combine
import Foundation

/// Network service class
public struct NetworkService {
    private let networkService: NetworkServiceProtocol

    init(_ networkService: NetworkServiceProtocol = AlamofireNetworkService()) {
        self.networkService = networkService
    }
}

extension NetworkService: NetworkServiceProtocol {
    public func requestAPI<Parameters: Encodable, Response: Codable>(
        info: RequestInfo,
        parameters: Parameters,
        decodable: Response.Type
    ) -> AnyPublisher<Response, NetworkError> {
        return networkService.requestAPI(info: info, parameters: parameters, decodable: decodable)
    }
}
