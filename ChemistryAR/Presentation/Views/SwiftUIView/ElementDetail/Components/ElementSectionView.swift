//
//  ElementSectionView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 30/10/2022.
//

import SwiftUI

struct OverviewSectionView: View {
    let overview: OverviewModel
    let parentSize: CGSize
    var body: some View {
        VStack(alignment: .leading) {
            HeaderSectionView(image: "flask", title: Localization.overviewTitle.localizedString)
                .padding(.bottom, 8)
            SectionRowView(
                width: parentSize.width,
                title: Localization.englishNameTitle.localizedString,
                desc: overview.name
            )
            SectionRowView(
                width: parentSize.width,
                title: Localization.descriptionTitle.localizedString,
                desc: overview.description
            )
            SectionRowView(
                width: parentSize.width,
                title: Localization.periodTitle.localizedString,
                desc: String.convertOptionalToString(item: overview.period)
            )
            SectionRowView(
                width: parentSize.width,
                title: Localization.groupTitle.localizedString,
                desc: overview.group
            )
            SectionRowView(
                width: parentSize.width,
                title: Localization.discoveredByTitle.localizedString,
                desc: overview.discoveredBy
            )
            SectionRowView(
                width: parentSize.width,
                title: Localization.namedByTitle.localizedString,
                desc: overview.nameBy
            )
            SectionRowView(
                width: parentSize.width,
                title: Localization.structureTitle.localizedString,
                desc: AppConstant.NoContent,
                image: overview.structureImage,
                isLastItem: true,
                isStructureImage: true
            )
        }
    }
}

struct NatureSectionView: View {
    let nature: NatureModel
    let parentSize: CGSize

    var body: some View {
        VStack(alignment: .leading) {
            HeaderSectionView(image: "flask", title: Localization.natureTitle.localizedString)
                .padding(.bottom, 8)
            SectionRowView(
                width: parentSize.width,
                title: Localization.standardStateTitle.localizedString,
                desc: nature.standardState
            )
            SectionRowView(
                width: parentSize.width,
                title: Localization.atomicMassTitle.localizedString,
                desc: String.convertOptionalToString(item: nature.atomicMass)
            )
            SectionRowView(
                width: parentSize.width,
                title: Localization.densityTitle.localizedString,
                desc: String.convertOptionalToString(item: nature.density)
            )
            SectionRowView(
                width: parentSize.width,
                title: Localization.meltTitle.localizedString,
                desc: String.convertOptionalToString(item: nature.melt)
            )
            SectionRowView(
                width: parentSize.width,
                title: Localization.boilTitle.localizedString,
                desc: String.convertOptionalToString(item: nature.boil)
            )
            SectionRowView(
                width: parentSize.width,
                title: Localization.molarHeatTitle.localizedString,
                desc: String.convertOptionalToString(item: nature.molarHeat),
                isLastItem: true
            )
        }
    }
}

struct AtomParametersView: View {
    let parameters: AtomParameter
    let parentSize: CGSize

    var body: some View {
        VStack(alignment: .leading) {
            HeaderSectionView(image: "flask", title: Localization.atomParametersTitle.localizedString)
                .padding(.bottom, 8)
            SectionRowView(
                width: parentSize.width,
                title: Localization.electronConfigurationTitle.localizedString,
                desc: parameters.electronConfiguration
            )
            makeChemotherapyView(chemotherapy: parameters.chemotherapy)
            SectionRowView(
                width: parentSize.width,
                title: Localization.spectralTitle.localizedString,
                desc: AppConstant.NoContent,
                image: parameters.spectralImage
            )
            SectionRowView(
                width: parentSize.width,
                title: Localization.electronAffinityTitle.localizedString,
                desc: String.convertOptionalToString(item: parameters.electronAffinity)
            )
            SectionRowView(
                width: parentSize.width,
                title: Localization.electronegativityTitle.localizedString,
                desc: String.convertOptionalToString(item: parameters.electronegativity)
            )
            SectionRowView(
                width: parentSize.width,
                title: Localization.ionizationEnergiesTitle.localizedString,
                desc: String.convertOptionalToString(item: parameters.ionizationEnergies),
                isLastItem: true
            )
        }
    }
}

private extension AtomParametersView {
    func makeChemotherapyView(chemotherapy: [Int]) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("\(Localization.chemotherapyTitle.localizedString):")
                .font(.system(size: 14))
                .foregroundColor(.black.opacity(0.7))
            HStack(spacing: 14) {
                ForEach(chemotherapy, id: \.self) { item in
                    Text( item > 0 ? "+\(item)" : "\(item)")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(.white)
                        .background(
                            Circle()
                                .fill(item > 0 ? Color.cBF2121 : Color.c225096)
                                .squareFrame(24)
                        )
                }
            }
            .padding(.leading, 8)
            Rectangle()
                .fill(.black.opacity(0.4))
                .frame(height: 0.5)
                .padding(.top, 6)
        }
        .padding(.horizontal, 32)
        .padding(.top, 4)
    }
}
