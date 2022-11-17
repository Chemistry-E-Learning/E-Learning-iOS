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
        return Bundle.Module.localizedString(forKey: self)
    }
}

extension String {
    static func convertOptionalToString<T>(item: T?) -> String {

        guard let itemWrapper = item else { return AppConstant.NoContent }
        return "\(itemWrapper)"
    }

    func getClassProgram() -> String {
        let result = self.components(separatedBy: " ")
        return result.last ?? ""
    }
}
