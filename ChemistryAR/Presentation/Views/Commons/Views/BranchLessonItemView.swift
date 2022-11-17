//
//  BranchLessonItemView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 25/10/2022.
//

import SwiftUI

struct BranchLessonItemView: View {
    let lessonTitle: String
    let lessonNumber: Int
    let durationRead: Int?

    var body: some View {
        HStack(spacing: 16) {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .squareFrame(60)
                .overlay (
                    Text("\(lessonNumber)")
                        .foregroundColor(.black.opacity(0.7))
                        .font(.system(size: 32, weight: .bold))
                )
                .clipped()
            VStack(alignment: .leading, spacing: -2) {
                Spacer()
                Text(lessonTitle)
                    .foregroundColor(.black.opacity(0.8))
                    .font(.system(size: 14, weight: .medium))
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
                Text("\(String.convertOptionalToString(item: durationRead)) Min read")
                    .foregroundColor(.black.opacity(0.2))
                    .font(.system(size: 12, weight: .light))
                Spacer()
            }
            .frame(height: 60)
            Spacer()
        }
        .padding(.horizontal, 12)
        .frame(height: 80)
        .shadow(color: .black.opacity(0.08), radius: 4, x: 1, y: 1)
        .background(
            Color.cF7F9FC.cornerRadius(14)
        )
    }
}
