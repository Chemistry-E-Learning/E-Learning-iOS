//
//  UserDefault.swift
//  ChemistryAR
//
//  Created by NhatMinh on 17/09/2022.
//

import Foundation

extension UserDefaults {
    func getString(forKey: String) -> String? {
        string(forKey: forKey)
    }

    func setString(data: String, forKey: String) {
        set(data, forKey: forKey)
    }

    func getBool(forKey: String) -> Bool {
        bool(forKey: forKey)
    }

    func setBool(data: Bool, forKey: String) {
        set(data, forKey: forKey)
    }

    func getDouble(forKey: String) -> Double {
        double(forKey: forKey)
    }

    func setDouble(data: Double, forKey: String) {
        set(data, forKey: forKey)
    }

    func getInteger(forKey: String) -> Int {
        integer(forKey: forKey)
    }

    func setInteger(data: Int, forKey: String) {
        set(data, forKey: forKey)
    }

    func getDictionary(forKey: String) -> [String: Any]? {
        dictionary(forKey: forKey)
    }

    func setDictionary(data: [String: Any]?, forKey: String) {
        set(data, forKey: forKey)
    }

    func getArray(forKey: String) -> [Any]? {
        array(forKey: forKey)
    }

    func setArray(data: [Any]?, forKey: String) {
        set(data, forKey: forKey)
    }

    func removeAll() {
        dictionaryRepresentation().forEach { removeObject(forKey: $0.key) }
        synchronize()
    }
}
