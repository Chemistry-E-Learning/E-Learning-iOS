//
//  NetworkServiceProtocol.swift
//  ChemistryAR
//
//  Created by NhatMinh on 17/09/2022.
//

import Alamofire
import Combine
import Foundation

/// NetworkServiceProtocol
public protocol NetworkServiceProtocol {
    /// Request api function
    /// - Returns: A publisher Data or Error
    func requestAPI<Parameters: Encodable, Response: Codable>(
        info: RequestInfo,
        parameters: Parameters,
        decodable: Response.Type
    ) -> AnyPublisher<Response, NetworkError>
}
