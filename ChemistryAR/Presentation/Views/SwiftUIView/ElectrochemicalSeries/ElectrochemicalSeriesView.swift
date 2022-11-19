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
                    ForEach(0..<10) { _ in
                        makeElectrochemicalItemView()
                            .padding(.top, 16)
                    }
                }
            }
            .background(
                Color.cE1E1E1.opacity(0.2)
            )
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

private extension ElectrochemicalSeriesView {
    func makeElectrochemicalItemView() -> some View {
        VStack(spacing: 0) {
            HStack(spacing: 18) {
                Circle()
                    .fill(Color.yellow)
                    .squareFrame(60)
                    .overlay {
                        Text("+")
                            .font(.system(size: 24, weight: .medium))
                            .foregroundColor(.white)
                    }
                VStack(alignment: .leading, spacing: 2) {
                    Text("Liti")
                        .font(.system(size: 20, weight: .medium))
                    Text("Điện áp: -2.92 (Volt)")
                        .font(.system(size: 16, weight: .regular))
                }
                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 16)
            Divider()
        }
    }
}
