//
//  ChemistryARApp.swift
//  ChemistryAR
//  Created by NhatMinh on 17/09/2022.
//

import SwiftUI

struct ChemistryARApp: View {
    let appState = AppState.shared

    var body: some View {
        NavigationView {
            ContentView()
                .navigationBarHidden(true)
        }
        .navigationViewStyle(.stack)
        .environmentObject(appState)
    }
}
