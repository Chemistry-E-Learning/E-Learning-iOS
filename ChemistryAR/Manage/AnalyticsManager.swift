//
//  AnalyticsManager.swift
//  ChemistryAR
//
//  Created by NhatMinh on 06/12/2022.
//

import Firebase
import SwiftUI

public class AnalyticsManager {
    public static let shared = AnalyticsManager()
    private init() {
        // _ = FirebaseManager.shared
    }

    public func getAppInstanceId() -> String? {
        return Analytics.appInstanceID()
    }

    public func setAnalyticsCollectionEnabled(_ enabled: Bool) {
        Analytics.setAnalyticsCollectionEnabled(enabled)
    }

    public func setUserID(_ userId: String?) {
        Analytics.setUserID(userId)
    }

    public func sendEvent(_ event: AnalyticsEvent) {
        if let userID = event.userID {
            Analytics.setUserID(userID)
        }

        if let userProperties = event.userProperties {
            for userProperty in userProperties {
                Analytics.setUserProperty(userProperty.value as? String, forName: userProperty.key)
            }
        }

        if let parameters = event.parameters {
            Analytics.logEvent(event.eventName, parameters: parameters)
        } else {
            Analytics.logEvent(event.eventName, parameters: nil)
        }
    }
}

