//
//  ElectrochemicalSeriesView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 31/10/2022.
//

import SwiftUI

struct ElectrochemicalSeriesView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Divider()
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    ForEach(Electrochemical.data) { model in
                        makeElectrochemicalItemView(model: model)
                            .padding(.top, 16)
                    }
                }
            }
            .background(Color.c1A1F2C.opacity(0.9))
        }
        .onAppear {
            GA4Manager.shared.trackScreenView(.electrochemicalSeries)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

private extension ElectrochemicalSeriesView {
    func makeElectrochemicalItemView(model: Electrochemical) -> some View {
        VStack(spacing: 0) {
            HStack(spacing: 18) {
                Circle()
                    .fill(model.color)
                    .squareFrame(60)
                    .overlay {
                        Text(model.chemo == 1 ? "+" : "\(model.chemo)+")
                            .font(.system(size: 24, weight: .medium))
                            .foregroundColor(.white)
                    }
                VStack(alignment: .leading, spacing: 2) {
                    Text(model.name)
                        .font(.system(size: 20, weight: .medium))
                    Text("\(Localization.voltageTitle.localizedString): \(model.voltage < 0 ? "" : "+")\(String(format: "%0.2f", model.voltage)) (Volt)")
                        .font(.system(size: 16, weight: .regular))
                }
                Spacer()
            }
            .foregroundColor(.white)
            .padding(.horizontal, 24)
            .padding(.bottom, 16)
            Rectangle()
                .fill(Color.white.opacity(0.9))
                .frame(height: 1)
        }
    }
}

struct Electrochemical: Identifiable {
    var id = UUID()
    let name: String
    let voltage: Double
    let chemo: Int
    let color: Color

    static let data = [
        Electrochemical(name: "Liti", voltage: -3.04, chemo: 1, color: Color(hex: 0xFCA118, alpha: 1)),
        Electrochemical(name: "Xezi", voltage: -3.01, chemo: 1, color: Color(hex: 0x3C3D56, alpha: 1)),
        Electrochemical(name: "Kali", voltage: -2.92, chemo: 1, color: Color(hex: 0x717311, alpha: 1)),
        Electrochemical(name: "Bari", voltage: -2.9, chemo: 2, color: Color(hex: 0x3C5646, alpha: 1)),
        Electrochemical(name: "Canxi", voltage: -2.87, chemo: 2, color: Color(hex: 0x18625E, alpha: 1)),
        Electrochemical(name: "Natri", voltage: -2.71, chemo: 1, color: Color(hex: 0x5D0505, alpha: 1)),
        Electrochemical(name: "Magie", voltage: -2.36, chemo: 2, color: Color(hex: 0x255607, alpha: 1)),
        Electrochemical(name: "Nhôm", voltage: -1.66, chemo: 3, color: Color(hex: 0x592A58, alpha: 1)),
        Electrochemical(name: "Kẽm", voltage: -0.76, chemo: 2, color: Color(hex: 0x2F394C, alpha: 1)),
        Electrochemical(name: "Sắt", voltage: -0.44, chemo: 2, color: Color(hex: 0x323220, alpha: 1)),
        Electrochemical(name: "Coban", voltage: -0.28, chemo: 2, color: Color(hex: 0x632E10, alpha: 1)),
        Electrochemical(name: "Niken", voltage: -0.25, chemo: 2, color: Color(hex: 0x103B63, alpha: 1)),
        Electrochemical(name: "Thiếc", voltage: -0.14, chemo: 2, color: Color(hex: 0x3D2536, alpha: 1)),
        Electrochemical(name: "Chì", voltage: -0.13, chemo: 2, color: Color(hex: 0x444444, alpha: 1)),
        Electrochemical(name: "Đồng", voltage: 0.34, chemo: 2, color: Color(hex: 0x2C5809, alpha: 1)),
        Electrochemical(name: "Bạc", voltage: 0.8, chemo: 1, color: Color(hex: 0x2A1063, alpha: 1)),
        Electrochemical(name: "Thuỷ Ngân", voltage: 0.85, chemo: 2, color: Color(hex: 0x33331C, alpha: 1)),
        Electrochemical(name: "Platin", voltage: 1.28, chemo: 2, color: Color(hex: 0x171B09, alpha: 1)),
        Electrochemical(name: "Vàng", voltage: 1.5, chemo: 3, color: Color(hex: 0x958F00, alpha: 1))
    ]
}
