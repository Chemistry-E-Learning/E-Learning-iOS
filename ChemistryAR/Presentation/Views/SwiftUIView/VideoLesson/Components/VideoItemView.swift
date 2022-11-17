//
//  ChapterItem.swift
//  ChemistryAR
//
//  Created by NhatMinh on 11/10/2022.
//

import SwiftUI

struct VideoItemView: View {
    let title: String
    let index: Int

    var body: some View {
        HStack {
            Image(systemName: AppConstant.PlayImage)
                .foregroundColor(.white)
                .squareFrame(44)
                .background(
                    Color.startButton.cornerRadius(24)
                )
            VStack(alignment: .leading, spacing: 4) {
                Text(Localization.lessonAttributeTitle.localizedString + " \(index)")
                    .foregroundColor(.gray)
                    .font(.system(size: 11, weight: .regular))
                Text(title)
                    .font(.system(size: 13, weight: .medium))
            }
            .padding(.leading, 4)
            Spacer()
        }
        .padding(.horizontal, 16)
        .frame(height: 72)
        .background(
            Color.white.cornerRadius(8)
        )
    }
}
