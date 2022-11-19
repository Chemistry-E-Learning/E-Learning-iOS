//
//  VirtualLabViewModel.swift
//  ChemistryAR
//
//  Created by NhatMinh on 18/11/2022.
//

import Combine
import Foundation

final class VirtualLabViewModel: ObservableObject {
    @Published var chemicals = ChemicalsList.emptyData
    @Published var reactantsResponse = [String]()
    @Published var isLoading = true
    @Published var isShowError = false
    @Published var isCompleted = false
    @Published var chemicalEquation = [String]()

    private let reactionUseCase: ReactionUseCase
    private var disposables = Set<AnyCancellable>()
    init(
        reactionUseCase: ReactionUseCase = DIContainer.shared.getReactionUseCase()
    ) {
        self.reactionUseCase = reactionUseCase
        doGetChemicalsList()
    }
}

// MARK: - API Function
extension VirtualLabViewModel {
    func doGetReactionResult(with reactants: [String]) {
        let param = ReactionRequest(reactants: reactants)
        reactionUseCase.doGetReactionResult(param: param)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                guard let self = self else { return }
                switch error {
                case .failure:
                    self.isShowError = true
                case .finished:
                    break
                }
                self.isLoading = false
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.reactantsResponse = response.reactants
                self.chemicalEquation = response.chemicalEquation
            }
            .store(in: &disposables)
    }

    func doGetChemicalsList() {
        reactionUseCase.doGetChemicalsList()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                guard let self = self else { return }
                switch error {
                case .failure:
                    self.isShowError = true
                case .finished:
                    break
                }
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.chemicals = response
            }
            .store(in: &disposables)
    }
}
