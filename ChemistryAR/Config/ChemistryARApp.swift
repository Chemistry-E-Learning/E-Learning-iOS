//
//  ChemistryARApp.swift
//  ChemistryAR
//
//  Created by NhatMinh on 17/09/2022.
//

import SwiftUI

@main
struct ChemistryARApp: App {
    let appState = AppState.shared

    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    .navigationBarHidden(true)
            }
            .navigationViewStyle(.stack)
            .environmentObject(appState)
        }
    }
}
