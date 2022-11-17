//
//  ChemicalView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 07/11/2022.
//

import SwiftUI

struct ChemicalView: View {
    @StateObject private var viewModel = ImageTrackingViewModel()
    @State private var isLastReactant = false
    @Binding var reactants: [String: String]

    let elementName: String
    let size: CGSize

    var body: some View {
        if let element = viewModel.currentElement {
            Rectangle()
                .fill(Color.c1D283A)
                .frame(width: size.width * 100, height: size.height * 104)
                .border(Color.black.opacity(0.3), width: 1)
                .overlay(
                    ZStack(alignment: .bottomTrailing) {
                        Text(element.symbol)
                            .font(.system(size: size.height * 50, weight: .medium))
                            .foregroundColor(.white)
                        Text(element.phase == .gas ? AppConstant.GasIndex : "")
                            .font(.system(size: size.height * 15, weight: .medium))
                            .foregroundColor(.white)
                            .offset(x: 20, y: -8)
                    }
                )
                .onAppear {
                    reactants.updateValue(
                        "\(element.symbol)\(element.phase == .gas ? AppConstant.GasIndex : "")",
                        forKey: elementName
                    )
                }
        } else {
            #warning("TODO: MinhNN44 - Animation here")
            Text("Is Loading")
                .onAppear {
                    viewModel.doGetElementInformation(with: elementName)
                }
        }
    }
}

private extension ChemicalView {
}
