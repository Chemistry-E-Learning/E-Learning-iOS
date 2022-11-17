//
//  LawItem.swift
//  ChemistryAR
//
//  Created by NhatMinh on 09/10/2022.
//

import SwiftUI

struct LawItem: View {
    let law: Series

    var body: some View {
        HStack(spacing: 20) {
            ImageFromUrlView(image: law.thumbImage?.url ?? "", isClearBackground: false)
                .squareFrame(64)
                .cornerRadius(12)
                .clipped()
            VStack(alignment: .leading, spacing: 4) {
                Text(law.seriesName)
                    .font(.system(size: 16, weight: .semibold))
                Text(law.author ?? AppConstant.NoContent)
                    .foregroundColor(.c4A4A4A)
                    .font(.system(size: 12, weight: .light))
                Spacer()
            }
            .redacted(if: law.id.isEmpty)
            .if(law.id.isEmpty, transform: { view in
                view.shimmerAnimation()
            })
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
