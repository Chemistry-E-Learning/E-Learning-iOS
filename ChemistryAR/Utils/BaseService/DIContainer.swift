//
//  DIContainer.swift
//  ChemistryAR
//
//  Created by NhatMinh on 17/09/2022.
//

import Foundation
import Swinject

final class DIContainer {
    let container = Container()

    /// Share instance
    public static let shared = DIContainer()

    private init() {
        generalInit()
    }

    private func generalInit() {
        // Repository
        //        container.register(ListContentRepository.self) { _ in
        //            ListContentHttpConnectionImpl()
        //        }

        // Usecase
        //        container.register(ListContentUseCase.self) { _ in
        //            ListContentUseCaseImpl()
        //        }

        // UserDefault
        //        container.register(UserDefaultsDataProtocol.self) { _ in
        //            UserDefaultsDataImpl.shared
        //        }
    }

    /// ListContentRepository
    //    func getListContentRepository() -> ListContentRepository {
    //        return container.resolve(ListContentRepository.self)!
    //    }

    /// ListContentUseCase
    //    func getListContentUseCase() -> ListContentUseCase {
    //        return container.resolve(ListContentUseCase.self)!
    //    }
}
