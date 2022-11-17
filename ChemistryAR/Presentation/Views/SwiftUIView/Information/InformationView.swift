//
//  InformationView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 08/10/2022.
//

import SwiftUI


struct InformationView: View {
    @StateObject private var viewModel = ImageTrackingViewModel()
    let elementName: String

    var body: some View {
        GeometryReader { geo in
            ZStack {
                if let _ = viewModel.currentElement {
                    ScrollView(showsIndicators: false) {
                        VStack {
                            OverviewSectionView(overview: viewModel.overview, parentSize: geo.size)
                            NatureSectionView(nature: viewModel.nature, parentSize: geo.size)
                            AtomParametersView(parameters: viewModel.atomParameters, parentSize: geo.size)
                        }
                        .padding(.bottom, geo.size.height * 0.36)
                        .background {
                            Color.white.ignoresSafeArea(.all)
                        }
                    }
                } else {
                    #warning("TODO: MinhNN44 - Animation here")
                    Text("Is Loading")
                }
            }
            .onAppear {
                viewModel.doGetElementInformation(with: elementName)
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
