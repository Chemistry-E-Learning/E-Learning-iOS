//
//  BranchItem.swift
//  ChemistryAR
//
//  Created by NhatMinh on 09/10/2022.
//

import SwiftUI

struct BranchItemView: View {
    let branch: Series

    var body: some View {
        VStack(alignment: .leading) {
            ImageFromUrlView(
                image: branch.thumbImage?.url ?? "",
                isClearBackground: false
            )
                .frame(height: 120)
                .cornerRadius(12, corners: [.topLeft, .topRight])
                .clipped()
            VStack(alignment: .leading) {
                Text(branch.seriesName)
                    .redacted(if: branch.seriesName == AppConstant.ShortText)
                    .if(branch.seriesName == AppConstant.ShortText){ view in
                        view.shimmerAnimation()
                    }
                    .font(.system(size: 16, weight: .semibold))
                    .fixedSize(horizontal: false, vertical: true)
                    .lineLimit(2)
                    .padding(.top, 8)
                Spacer()
                HStack {
                    Circle()
                        .fill(Color.c7A2F81)
                        .frame(width: 24, height: 24)
                        .overlay {
                            Image(systemName: AppConstant.PlayImage)
                                .foregroundColor(.white)
                                .font(.system(size: 12))
                        }
                    Text(Localization.startReadingTitle.localizedString)
                        .font(.system(size: 13, weight: .medium))
                }
                .padding(.bottom, 8)
            }
            .padding(.leading, 16)
            Spacer()
        }
        .frame(height: 216)
        .background(
            Color.white.cornerRadius(12)
        )
        .shadow(color: .black.opacity(0.08), radius: 8, x: 2, y: 2)
    }
}
