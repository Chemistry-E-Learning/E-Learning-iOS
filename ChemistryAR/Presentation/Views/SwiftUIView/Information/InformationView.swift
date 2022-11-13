//
//  InformationView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 08/10/2022.
//

import SwiftUI


struct InformationView: View {
    @StateObject private var viewModel = ElementTrackingViewModel()
    let elementName: String

    var body: some View {
        ZStack {
            if let element = viewModel.currentElement {
                VStack(alignment: .leading) {
                    Text(element.name)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 20)
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 12) {
                            makeInformationCell(
                                title: "What is \(element.name)",
                                context: element.summary
                            )
                            makeElementPropertiesCell()
                        }
                    }
                    .padding(.top, 8)
                    .padding(.horizontal, 20)
                    .background(Color.cE1E1E1.opacity(0.2))
                }
            } else {
                #warning("TODO: MinhNN44 - Animation here")
                Text("Is Loading")
            }
        }
        .onAppear {
            viewModel.doGetElementInformation(with: elementName)
        }
        .padding(.top, 12)
        .frame(
            width: UIScreen.main.bounds.width * 0.8,
            height: UIScreen.main.bounds.height * 0.8
        )
        .background(Color.white)
        .cornerRadius(12)
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
