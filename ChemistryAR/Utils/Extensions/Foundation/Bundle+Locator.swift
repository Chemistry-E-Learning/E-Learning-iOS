//
//  Bundle+Locator.swift
//  ChemistryAR
//
//  Created by NhatMinh on 17/09/2022.
//

import Foundation

class BundleLocator {}
extension Bundle {
    static var Module: Bundle {
        Bundle(for: BundleLocator.self)
    }

    func localizedString(forKey key: String) -> String {
        self.localizedString(forKey: key, value: nil, table: nil)
    }
}

