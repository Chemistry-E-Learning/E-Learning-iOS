//
//  String+Localizable.swift
//  ChemistryAR
//
//  Created by NhatMinh on 17/09/2022.
//

import Foundation

class StringLocalizable {}
extension String {
    var localizedString: String {
        Bundle.Module.localizedString(forKey: self)
    }
}
