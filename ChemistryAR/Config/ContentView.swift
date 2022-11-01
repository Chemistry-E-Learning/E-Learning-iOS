//
//  ContentView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 17/09/2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    @State private var selectedTab = TabItem.home
    @State private var isActive = false

    var body: some View {
        ZStack {
            if isActive {
                SolubilityTableView(
                    isShowSolubilityTableView: .constant(false),
                    elementList: .constant(
                        SolubilityModelList.readJSONFromFile()?.solubilityModelMatrix()
                        ?? SolubilityModelList(data: []).solubilityModelMatrix()
                    )
                )
            } else {
                SplashAnimationView()
            }
        }
        .onAppear {
            AppState.shared.route()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
                self.isActive = true
            }
        }
    }
}

private extension ContentView {
    @ViewBuilder var contentView: some View {
        switch appState.state {
        case .home:
            homeView
        case .onboarding:
            onboarding
        }
    }

    var onboarding: some View {
        OnboardingView()
    }

    var homeView: some View {
        MainTabView(selectedTab: $selectedTab)
    }
}
