//
//  UserSettingViewModel.swift
//  ChemistryAR
//
//  Created by NhatMinh on 06/12/2022.
//

import Foundation
import Combine

final class UserSettingViewModel: ObservableObject {
    @Published var user = UserViewEntity.default
    @Published var isLoading = true
    @Published var isShowError = false

    private var disposables = Set<AnyCancellable>()
    init() {
        getUserProfile()
    }
}

// MARK: - UserDefault Function
extension UserSettingViewModel {
    func getUserProfile() {
        if let data = UserDefaults.standard.data(forKey: "user") {
            do {
                let decoder = JSONDecoder()
                user = try decoder.decode(UserViewEntity.self, from: data)
            } catch {
                print("Unable to Decode Note (\(error))")
            }
        }
    }

    func sendEventGA4(){
    }
}
