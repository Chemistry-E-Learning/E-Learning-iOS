//
//  AnalyticsEvent.swift
//  ChemistryAR
//
//  Created by NhatMinh on 06/12/2022.
//

import Foundation

public protocol AnalyticsEvent {
    var eventName: String { get }
    var parameters: [String: Any]? { get }
    var userID: String? { get }
    var userProperties: [String: Any]? { get }
}
