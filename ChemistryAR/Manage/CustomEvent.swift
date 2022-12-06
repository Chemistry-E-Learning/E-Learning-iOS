//
//  CustomEvent.swift
//  ChemistryAR
//
//  Created by NhatMinh on 06/12/2022.
//

import Foundation

public struct CustomEvent: AnalyticsEvent {
    public var eventName: String {
        customEventName
    }
    public var userID: String?
    let customEventName: String
    let parameterList: [String: Any]?
    let userPropertyList: [String: Any]?

    public init(
        customEventName: String,
        parameterList: [String: Any]? = nil,
        userID: String? = nil,
        userPropertyList: [String: Any]? = nil
    ) {
        self.customEventName = customEventName
        self.userID = userID
        self.parameterList = parameterList
        self.userPropertyList = userPropertyList
    }

    public var parameters: [String: Any]? {
        parameterList
    }

    public var userProperties: [String: Any]? {
        userPropertyList
    }
}
