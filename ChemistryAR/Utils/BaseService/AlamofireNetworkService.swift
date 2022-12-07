//
//  AlamofireNetworkService.swift
//  ChemistryAR
//
//  Created by NhatMinh on 17/09/2022.
//

import Alamofire
import Combine
import Foundation

struct AlamofireNetworkService {
    static func defaultSession() -> Session {
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 60
        let session = Session(configuration: configuration)
        return session
    }

    private let sessionManager: Session

    init(with session: Session = defaultSession()) {
        sessionManager = session
    }
}

extension AlamofireNetworkService: NetworkServiceProtocol {
    func requestAPI<Parameters: Encodable, Response: Codable>(
        info: RequestInfo,
        parameters: Parameters,
        decodable: Response.Type
    ) -> AnyPublisher<Response, NetworkError> {
        let httpMethod = getHTTPMethod(info.method)

        let jsonEncoder = JSONEncoder()
        // jsonEncoder.keyEncodingStrategy = .c

        var paramsEncoder: ParameterEncoder = JSONParameterEncoder(encoder: jsonEncoder)

        if httpMethod == Alamofire.HTTPMethod.get {
            let encoder = URLEncodedFormEncoder(keyEncoding: .convertToSnakeCase)
            paramsEncoder = URLEncodedFormParameterEncoder(encoder: encoder)
        }

        let afHeaders = convertHeaders(info.headers)
        let session = sessionManager.request(
            info.url,
            method: httpMethod,
            parameters: parameters,
            encoder: paramsEncoder,
            headers: afHeaders
        )
            .responseString { response in
                // print("API Response: \(response.result)")
            }
            .validate(contentType: [
                HTTPHeaderValue.applicationJson.rawValue,
                HTTPHeaderValue.textHTML.rawValue
            ])
            .publishData()
            .value()
            .tryMap { data -> Response in
                return try tryToCatchError(from: data)
            }
            .mapError { error -> NetworkError in
                if let afError = error as? AFError {
                    return NetworkError(initialError: afError, backendError: nil)
                } else if let networkError = error as? NetworkError {
                    return networkError
                } else {
                    return NetworkError(
                        initialError: AFError.sessionTaskFailed(error: error),
                        backendError: nil
                    )
                }
            }
        return session.eraseToAnyPublisher()
    }

    private func tryToCatchError<R: Decodable>(from data: Data) throws -> R {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        if let backendError = try? decoder.decode(BackendError.self, from: data) {
            let networkError = NetworkError(initialError: nil, backendError: backendError)
            throw networkError
        } else {
            do {
                let result = try decoder.decode(R.self, from: data)
                return result
            } catch {
                let networkError = NetworkError(
                    initialError: .sessionTaskFailed(error: error),
                    backendError: nil
                )
                throw networkError
            }
        }
    }
}

private extension AlamofireNetworkService {
    func getHTTPMethod(_ method: HTTPMethod) -> Alamofire.HTTPMethod {
        let returnMethod: Alamofire.HTTPMethod
        switch method {
        case .get:
            returnMethod = .get
        case .post:
            returnMethod = .post
        case .put:
            returnMethod = .put
        case .patch:
            returnMethod = .patch
        case .delete:
            returnMethod = .delete
        }

        return returnMethod
    }

    func convertHeaders(_ headers: HTTPHeader?) -> Alamofire.HTTPHeaders? {
        guard let headers: HTTPHeader = headers else {
            // Logger.debug(message: "Headers nil")
            return nil
        }
        return Alamofire.HTTPHeaders(headers)
    }
}
