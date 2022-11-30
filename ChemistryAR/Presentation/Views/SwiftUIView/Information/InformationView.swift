//
//  InformationView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 08/10/2022.
//

import SwiftUI


struct InformationView: View {
    let elementName: String
    @StateObject private var viewModel = ElementCardTrackingViewModel()

    var body: some View {
        GeometryReader { geo in
            ZStack {
                ScrollView(showsIndicators: false) {
                    VStack {
                        OverviewSectionView(
                            overview: viewModel.overview,
                            parentSize: geo.size
                        )
                            .redacted(if: viewModel.isLoading)
                        NatureSectionView(
                            nature: viewModel.nature,
                            parentSize: geo.size
                        )
                            .redacted(if: viewModel.isLoading)
                        AtomParametersView(
                            parameters: viewModel.atomParameters,
                            parentSize: geo.size
                        )
                            .redacted(if: viewModel.isLoading)
                    }
                    .padding(.bottom, geo.size.height * 0.36)
                    .background {
                        Color.white.ignoresSafeArea(.all)
                    }
                }
            }
            .onAppear {
                viewModel.doGetElementInformation(with: elementName)
            }
        }
    }
}

struct Test: PreviewProvider {
    static var previews: some View {
        InformationView(elementName: "copper")
    }
}
