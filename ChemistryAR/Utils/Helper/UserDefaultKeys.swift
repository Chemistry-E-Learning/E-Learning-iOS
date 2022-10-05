//
//  UserDefaultCommon.swift
//  BaberShopBooking
//
//  Created by NhatMinh on 01/03/2022.
//

import Foundation

enum UserDefaultKeys: String {
    case username
    case avatar
    case isFirstLaunch

    var stringValue: String {
        "UserDefaultsDataStore.Key.\(self.rawValue)"
    }
}

class UserDefaultsData {
    static let shared = UserDefaultsData()
    private let userDefaults = UserDefaults(suiteName: "group.CEL.app")!

    var username: String {
        get {
            return (UserDefaults.standard.value(forKey: UserDefaultKeys.username.stringValue) as? String) ?? "Anonymous"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.username.stringValue)
        }
    }

    var avatar: String? {
        get {
            self.userDefaults.string(forKey: UserDefaultKeys.avatar.stringValue)
        }
        set {
            self.userDefaults.set(newValue, forKey: UserDefaultKeys.avatar.stringValue)
        }
    }

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
