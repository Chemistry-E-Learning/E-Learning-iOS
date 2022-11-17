//
//  HeaderListCustomView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 01/11/2022.
//

import SwiftUI

struct HeaderListCustomView: View {
    @Binding var isPushToCurrentView: Bool
    let series: Series
    let lessonCount: Int
    let durationTotal: Int
    let parentHeight: CGFloat

    var body: some View {
        GeometryReader { geo in
            ImageFromUrlView(image: series.coverImage?.url ?? "")
                .overlay {
                    ZStack(alignment: .topLeading) {
                        Color.black.opacity(0.4)
                        VStack(alignment: .leading, spacing: 28) {
                            BackCircleButton {
                                isPushToCurrentView = false
                            }
                            .padding(.horizontal, 8)
                            VStack(alignment: .leading, spacing: 8) {
                                Text(series.seriesName)
                                    .font(.system(size: 26, weight: .bold))
                                    .foregroundColor(.white)
                                Text("\(durationTotal) \(Localization.timeAttributeTitle.localizedString) - \(lessonCount) \(Localization.lessonsAttributeTitle.localizedString)")
                                    .font(.system(size: 13, weight: .regular))
                                    .foregroundColor(.white.opacity(0.9))
                            }
                            Text(series.description ?? AppConstant.NoContent)
                                .multilineTextAlignment(.leading)
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(.white)
                                .lineLimit(4)
                        }
                        .padding(.horizontal, 28)
                        .offset(y: parentHeight * 0.1)
                    }
                }
                .frame(height: parentHeight * 0.38)
                .clipped()
        }
    }
}
