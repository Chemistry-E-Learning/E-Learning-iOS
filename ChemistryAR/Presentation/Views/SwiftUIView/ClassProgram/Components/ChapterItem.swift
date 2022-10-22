//
//  ChapterItem.swift
//  ChemistryAR
//
//  Created by NhatMinh on 11/10/2022.
//

import SwiftUI

struct ChapterItem: View {
    var body: some View {
        HStack(spacing: 20) {
            Image("boyle")
                .resizable()
                .scaledToFill()
                .frame(width: 64, height: 64)
                .clipped()
            VStack(alignment: .leading, spacing: 4) {
                Text("Robert Boyle")
                    .foregroundColor(.c4A4A4A)
                    .font(.system(size: 12, weight: .light))
                Text("Boyle's Law")
                    .font(.system(size: 16, weight: .semibold))
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

struct ChapterItem_Previews: PreviewProvider {
    static var previews: some View {
        ChapterItem()
    }
}
