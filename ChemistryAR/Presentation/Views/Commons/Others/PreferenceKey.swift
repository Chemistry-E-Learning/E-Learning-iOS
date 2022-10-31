//
//  PreferenceKey.swift
//  ChemistryAR
//
//  Created by NhatMinh on 30/10/2022.
//

import SwiftUI

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}
