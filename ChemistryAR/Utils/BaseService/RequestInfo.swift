//
//  RequestInfo.swift
//  ChemistryAR
//
//  Created by NhatMinh on 17/09/2022.
//

import Alamofire
import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

public enum HTTPHeaderKey: String {
    case authorization = "Authorization"
    case contentType = "Content-Type"
    case accept = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case accessToken = "Access-Token"

    var lowercasedValue: String {
        rawValue.lowercased()
    }

    var uppercasedValue: String {
        rawValue.uppercased()
    }
}

public enum HTTPHeaderValue: String {
    case applicationJson = "application/json"
    case textHTML = "text/html"
}

/// HTTP Header
public typealias HTTPHeader = [String: String]

public struct NetworkError: Error {
    let initialError: AFError?
    let backendError: BackendError?
}

extension NetworkError {
    /// Get message network error
    /// - Returns: String
    func getMessageNetworkError() -> String {
        guard let error = self.backendError else {
            let initialError = self.initialError?.localizedDescription.split(separator: ":")
            return String(initialError?.last ?? "")
        }
        return error.message
    }
}

public struct BackendError: Codable, Error {
    let message: String
}

/// RequestInfo
public struct RequestInfo {
    let url: URL
    let method: HTTPMethod
    let headers: HTTPHeader?

    /// Initialization
    /// - Parameters:
    ///   - url: request URL
    ///   - method: request http method
    ///   - headers: request header
    public init(
        url: URL,
        method: HTTPMethod,
        customHeader: HTTPHeader? = nil
    ) {
        self.url = url
        self.method = method
        var headers: HTTPHeader = [:]

        self.headers = headers
    }
}
