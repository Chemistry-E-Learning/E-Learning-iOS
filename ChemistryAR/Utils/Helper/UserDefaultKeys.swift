//
//  UserDefaultCommon.swift
//  BaberShopBooking
//
//  Created by NhatMinh on 01/03/2022.
//

import Foundation

enum UserDefaultKeys: String {
    case user
    case isFirstLaunch

    var stringValue: String {
        "UserDefaultsDataStore.Key.\(self.rawValue)"
    }
}

class UserDefaultsData {
    static let shared = UserDefaultsData()
    private let userDefaults = UserDefaults(suiteName: "group.CEL.app")!
    
    var isFirstLaunch: Bool {
        get {
            userDefaults.register(defaults: [UserDefaultKeys.isFirstLaunch.stringValue: true])
            return userDefaults.bool(forKey: UserDefaultKeys.isFirstLaunch.stringValue)
        }
        set {
            userDefaults.set(newValue, forKey: UserDefaultKeys.isFirstLaunch.stringValue)
        }
    }
}
