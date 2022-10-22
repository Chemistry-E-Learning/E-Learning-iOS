//
//  NavigationLazyView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 11/10/2022.
//

import SwiftUI

struct NavigationLazyView<Content: View>: View {
    let build: () -> Content

    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }

    var body: Content {
        build()
    }
}
