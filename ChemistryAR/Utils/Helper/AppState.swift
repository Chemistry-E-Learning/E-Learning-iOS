//
//  AppState.swift
//  ChemistryAR
//
//  Created by NhatMinh on 04/10/2022.
//

import Combine

final class AppState: ObservableObject {
    static let shared = AppState()
    var userDefaults = UserDefaultsData.shared
    @Published var state: State = .onboarding

    private init() { }

    enum State {
        case onboarding
        case home
    }

    func route() {
        if userDefaults.isFirstLaunch {
            state = .onboarding
        } else {
            state = .home
        }
    }
}
