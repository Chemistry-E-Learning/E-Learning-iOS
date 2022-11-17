//
//  ProgramItem.swift
//  ChemistryAR
//
//  Created by NhatMinh on 09/10/2022.
//

import SwiftUI

struct ProgramItemView: View {
    let program: Series
    let videoNumber: Int

    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    ImageFromUrlView(image: program.thumbImage?.url ?? "")
                        .frame(width: geo.size.width / 2)
                        .offset(x: 20, y: 36)
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text(program.seriesName)
                        .font(.system(size: 32, weight: .medium))
                        .padding(.bottom, 8)
                    VStack(alignment: .leading, spacing: 4) {
                        Text("\(program.childSeriesNumber ?? 2) \(Localization.chaptersAttributeTitle.localizedString) - \(videoNumber) Videos")
                        Text(program.description ?? "")
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .foregroundColor(.c4A4A4A.opacity(0.6))
                    .font(.system(size: 14, weight: .regular))
                }
                .redacted(if: program.id.isEmpty)
                .padding(.horizontal, 16)
            }
            .if(program.id.isEmpty) { view in
                view
                    .shimmerAnimation()
            }
            .frame(width: 300, height: 260)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.purple.opacity(0.22))
                    .blur(radius: 8)
                    .cornerRadius(12)
                    .offset(y: 50)
                    .shadow(color: .black.opacity(0.1), radius: 5, x: -5, y: -5)
                    .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
            )
        }
    }
}
