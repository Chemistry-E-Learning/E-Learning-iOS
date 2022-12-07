//
//  AnkanPropertiesView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 03/12/2022.
//

import SwiftUI

struct AnkanPropertiesView: View {
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView(showsIndicators: false) {
                ForEach(AnkanModel.data) { item in
                    makeAnkanItemView(ankan: item)
                }
            }
        }
        .onAppear {
            GA4Manager.shared.trackScreenView(.alkaneProperties)
        }
        .background(Color.c1A1F2C.opacity(0.9))
    }
}

struct AnkanPropertiesView_Previews: PreviewProvider {
    static var previews: some View {
        AnkanPropertiesView()
    }
}

private extension AnkanPropertiesView {
    func makeAnkanItemView(ankan: AnkanModel) -> some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(spacing: 0) {
                    Circle()
                        .fill(ankan.color)
                        .squareFrame(16)
                        .frame(width: 60, height: 70)
                    Image("celsius")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .squareFrame(20)
                        .foregroundColor(.white)
                        .frame(width: 60, height: 70)
                }
                VStack(alignment: .leading, spacing: 0) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(ankan.name)
                            .font(.system(size: 18, weight: .bold))
                        Text("\(Localization.densityTitle.localizedString): \(String(format: "%0.2f", ankan.specificWeight)) (g/cm³)")
                            .font(.system(size: 16, weight: .medium))
                    }
                    .frame(height: 70)
                    Rectangle()
                        .fill(Color.white.opacity(0.8))
                        .frame(height: 0.5)
                        .padding(.trailing, 20)
                    VStack(alignment: .leading, spacing: 4) {
                        HStack(spacing: 0) {
                            Text(Localization.meltTitle.localizedString)
                                .font(.system(size: 16, weight: .medium))
                            Spacer()
                            Text("\(String(format: "%0.1f", ankan.meltingPoint))")
                                .font(.system(size: 16, weight: .bold))
                            Text("°C")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(ankan.color)
                        }
                        .padding(.trailing, 20)
                        HStack(spacing: 0) {
                            Text(Localization.boilTitle.localizedString)
                                .font(.system(size: 16, weight: .medium))
                            Spacer()
                            Text("\(String(format: "%0.1f", ankan.boilPoint))")
                                .font(.system(size: 16, weight: .bold))
                            Text("°C")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(ankan.color)
                        }
                        .padding(.trailing, 20)
                    }
                    .frame(height: 70)
                }
                .foregroundColor(.white)
            }
            .padding(.vertical, 4)
            Rectangle()
                .fill(ankan.color)
                .frame(height: 1)
        }
    }
}

struct AnkanModel: Identifiable {
    let id = UUID()
    let name: String
    let specificWeight: Float
    let meltingPoint: Float
    let boilPoint: Float
    let color: Color
    static var data =  [
        AnkanModel(
            name: "Methane",
            specificWeight: 0.415,
            meltingPoint: -182.5,
            boilPoint: -161.5,
            color: Color(hex: 0xFCA118)
        ),
        AnkanModel(
            name: "Ethan",
            specificWeight: 0.583,
            meltingPoint: -187.6,
            boilPoint: -42.1,
            color: Color(hex: 0x358210)
        ),
        AnkanModel(
            name: "Propen",
            specificWeight: 0.5,
            meltingPoint: -138.3,
            boilPoint: -0.5,
            color: Color(hex: 0xB16686)
        ),
        AnkanModel(
            name: "Bhutan",
            specificWeight: 0.415,
            meltingPoint: -182.5,
            boilPoint: -161.5,
            color: Color(hex: 0xA6E342)
        ),
        AnkanModel(
            name: "Isobutan",
            specificWeight: 0.563,
            meltingPoint: -159.4,
            boilPoint: -11.7,
            color: Color(hex: 0x7117B8)
        ),
        AnkanModel(
            name: "Pentane",
            specificWeight: 0.626,
            meltingPoint: -129.7,
            boilPoint: 36.07,
            color: Color(hex: 0xFA814D)
        ),
        AnkanModel(
            name: "Isopentane",
            specificWeight: 0.62,
            meltingPoint: -159.9,
            boilPoint: 27.9,
            color: Color(hex: 0x92B0FB)
        ),
        AnkanModel(
            name: "Neopentane",
            specificWeight: 0.613,
            meltingPoint: -16.6,
            boilPoint: 9.5,
            color: Color(hex: 0xE8DB64)
        )
    ]
}
