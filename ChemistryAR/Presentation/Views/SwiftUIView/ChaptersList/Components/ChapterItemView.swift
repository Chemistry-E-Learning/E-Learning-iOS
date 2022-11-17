//
//  LessonItem.swift
//  ChemistryAR
//
//  Created by NhatMinh on 11/10/2022.
//

import SwiftUI

struct ChapterItemView: View {
    let programDetail: Series
    let chapter: Int

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(Localization.chapterAttributeTitle.localizedString + " \(chapter)")
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(.white.opacity(0.8))
                Text(programDetail.seriesName)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.white)
            }
            Spacer()
            Image(systemName: "chevron.forward")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.white)
                .squareFrame(40)
                .background(
                    Circle()
                        .fill(Color.black.opacity(0.3))
                )
        }
        .padding(.horizontal, 20)
        .frame(height: 120)
        .background(
            ZStack{
                ImageFromUrlView(image: programDetail.coverImage?.url ?? "")
                    .frame(height: 120)
                    .blur(radius: 2)
                    .clipped()
                Color.gray.opacity(0.3)
            }
                .cornerRadius(16)
        )
    }
}
