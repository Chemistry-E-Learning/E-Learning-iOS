//
//  InformationView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 08/10/2022.
//

import SwiftUI


struct InformationView: View {
    let dataTest = [
        "To start the tour with the periodic table of elements, the first element to come across is Hydrogen, whose chemical symbol is H. It is the first and most basic among all the elements in the universe. It is also the lightest element in the periodic table, and 90% of all the atoms in the universe are hydrogen atoms",
        "The chemist Lavoisier gives the name hydrogen. It got its name from the Greek word “hydro” meaning water. Lavoisier knew that it existed in every water molecule."
    ]
    var body: some View {
        VStack(alignment: .leading) {
            Text("Hydrogen")
                .fontWeight(.semibold)
                .padding(.horizontal, 20)
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 12) {
                    makeInformationCell(title: "What is Hydrogen", context: dataTest)
                    makeElementPropertiesCell()
                }
            }
            .padding(.top, 8)
            .padding(.horizontal, 20)
            .background(Color.cE1E1E1.opacity(0.2))
        }
        .padding(.top, 12)
        .background(Color.white)
        .cornerRadius(12)
    }
}

private extension InformationView {
    func makeInformationCell(title: String, context: [String]) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 13, weight: .medium))
            ForEach(context, id: \.self) { content in
                BulletCell(content: content)
            }
        }
    }
    func makeElementPropertiesCell() -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Element Properties")
                .font(.system(size: 13, weight: .medium))
            ForEach(Property.data) { item in
                PropertyCell(property: item)
            }
        }
    }
}

struct Property: Identifiable {
    var id = UUID()
    var key: String
    var value: String

    static let data = [
        Property(key: "Standard State", value: "Gas"),
        Property(key: "Atomic Mass", value: "1.0080 u"),
        Property(key: "Electron Configuration", value: "1s1"),
        Property(key: "Oxidation States", value: "+1, -1"),
        Property(key: "Electronegativity", value: "2.2"),
        Property(key: "Atomic Radius", value: "120 pm"),
        Property(key: "Ionization Energy", value: "13.598 eV"),
        Property(key: "Electron Affinity", value: "0.754 eV"),
        Property(key: "Melting Point", value: "13.81 K"),
        Property(key: "Boiling Point", value: "20.28 K"),
        Property(key: "Density", value: "0.00008988 g/cm³"),
    ]
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

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView()
            .background(Color.red)
    }
}
