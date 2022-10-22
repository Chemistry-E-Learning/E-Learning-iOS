//
//  LawItem.swift
//  ChemistryAR
//
//  Created by NhatMinh on 09/10/2022.
//

import SwiftUI

struct LawItem: View {
    var body: some View {
        HStack(spacing: 20) {
            Image("boyle")
                .resizable()
                .scaledToFill()
                .frame(width: 64, height: 64)
                .cornerRadius(12)
                .clipped()
            VStack(alignment: .leading, spacing: 4) {
                Text("Boyle's Law")
                    .font(.system(size: 16, weight: .semibold))
                Text("Robert Boyle")
                    .foregroundColor(.c4A4A4A)
                    .font(.system(size: 12, weight: .light))
                Spacer()
            }
            .padding(.top, 12)
            Spacer()
        }
        .padding(.horizontal, 8)
        .frame(height: 80)
        .background(
            Color.white.cornerRadius(12)
        )
        .shadow(color: .black.opacity(0.08), radius: 8, x: 2, y: 2)
    }
}

struct LawItem_Previews: PreviewProvider {
    static var previews: some View {
        LawItem()
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
            .previewDisplayName("Default preview")
            .background(Color.red.opacity(0.6))
    }
}
