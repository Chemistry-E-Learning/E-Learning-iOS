//
//  Logger.swift
//  ChemistryAR
//
//  Created by NhatMinh on 17/09/2022.
//

import Foundation

/// Logger class
final class Logger {
    static var contents = "Article"
    static var isLogEnable: Bool {
    #if DEBUG
        return true
    #else
        return false
    #endif
    }
}
