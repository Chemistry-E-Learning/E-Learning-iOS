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
        //Repository
        container.register(SeriesRepository.self) { _ in
            SeriesHttpConnectionImpl()
        }
        container.register(ElementRepository.self) { _ in
            ElementHttpConnectionImpl()
        }
        container.register(ReactionRepository.self) { _ in
            ReactionHttpConnectionImpl()
        }
        container.register(LessonRepository.self) { _ in
            LessonHttpConnectionImpl()
        }
        container.register(EntityRepository.self) { _ in
            EntityHttpConnectionImpl()
        }


        // UseCase
        container.register(SeriesUseCase.self) { _ in
            SeriesUseCaseImpl()
        }
        container.register(ElementUseCase.self) { _ in
            ElementUseCaseImpl()
        }
        container.register(ReactionUseCase.self) { _ in
            ReactionUseCaseImpl()
        }
        container.register(LessonUseCase.self) { _ in
            LessonUseCaseImpl()
        }
        container.register(EntityUseCase.self) { _ in
            EntityUseCaseImpl()
        }

        // UserDefault
        //        container.register(UserDefaultsDataProtocol.self) { _ in
        //            UserDefaultsDataImpl.shared
        //        }
    }

    func getSeriesRepository() -> SeriesRepository {
        return container.resolve(SeriesRepository.self)!
    }

    func getSeriesUseCase() -> SeriesUseCase {
        return container.resolve(SeriesUseCase.self)!
    }

    func getElementRepository() -> ElementRepository {
        return container.resolve(ElementRepository.self)!
    }

    func getElementUseCase() -> ElementUseCase {
        return container.resolve(ElementUseCase.self)!
    }

    func getReactionRepository() -> ReactionRepository {
        return container.resolve(ReactionRepository.self)!
    }

    func getReactionUseCase() -> ReactionUseCase {
        return container.resolve(ReactionUseCase.self)!
    }

    func getLessonRepository() -> LessonRepository {
        return container.resolve(LessonRepository.self)!
    }

    func getLessonUseCase() -> LessonUseCase {
        return container.resolve(LessonUseCase.self)!
    }

    func getEntityRepository() -> EntityRepository {
        return container.resolve(EntityRepository.self)!
    }

    func getEntityUseCase() -> EntityUseCase {
        return container.resolve(EntityUseCase.self)!
    }
}
