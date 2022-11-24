//
//  InformationView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 08/10/2022.
//

import SwiftUI


struct InformationView: View {
    @StateObject private var viewModel: ImageTrackingViewModel
    let overview: OverviewModel
    let nature: NatureModel
    let atomParameters: AtomParameter

    init(
        overview: OverviewModel = OverviewModel.emptyData,
        nature: NatureModel = NatureModel.emptyData,
        atomParameter: AtomParameter = AtomParameter.emptyData,
        elementName: String = "",
        isTrackingImage: Bool = true
    ) {
        self.overview = overview
        self.nature = nature
        self.atomParameters = atomParameter

        _viewModel = .init(wrappedValue: ImageTrackingViewModel(isTrackingView: isTrackingImage))
        if isTrackingImage {
            viewModel.doGetElementInformation(with: elementName)
        }
    }
    var body: some View {
        GeometryReader { geo in
            ZStack {
                ScrollView(showsIndicators: false) {
                    VStack {
                        OverviewSectionView(
                            overview: viewModel.isLoading ? viewModel.overview : overview,
                            parentSize: geo.size
                        )
                            .redacted(if: viewModel.isLoading)
                        NatureSectionView(
                            nature: viewModel.isLoading ? viewModel.nature : nature,
                            parentSize: geo.size
                        )
                            .redacted(if: viewModel.isLoading)
                        AtomParametersView(
                            parameters: viewModel.isLoading ? viewModel.atomParameters : atomParameters,
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
            .onDisappear {
                print("MinhNN44")
            }
        }
    }
}

private extension InformationView {
    func makeInformationCell(title: String, context: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 13, weight: .medium))
            BulletCell(content: context)
        }
    }
    func makeElementPropertiesCell() -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Element Properties")
                .font(.system(size: 13, weight: .medium))
            ForEach(viewModel.properties ?? []) { item in
                PropertyCell(property: item)
            }
        }
    }
}

struct Property: Identifiable {
    var id = UUID()
    var key: String
    var value: String
}

struct PropertyCell: View {
    let property: Property
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("\(property.key):")
                    .foregroundColor(.c4A4A4A)
                    .font(.system(size: 12))
                Spacer()
                Text("\(property.value)")
                    .foregroundColor(.c081645)
                    .font(.system(size: 12))
            }
            Divider()
        }
    }
}

struct BulletCell: View {
    let content: String
    var body: some View {
        Text("\u{2022} \(content)")
            .foregroundColor(.c4A4A4A)
            .lineSpacing(2)
            .font(.system(size: 12))
            .multilineTextAlignment(.leading)
    }
}

struct Test: PreviewProvider {
    static var previews: some View {
        InformationView(elementName: "copper")
    }
}
