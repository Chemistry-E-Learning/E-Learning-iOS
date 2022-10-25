//
//  LessonItem.swift
//  ChemistryAR
//
//  Created by NhatMinh on 11/10/2022.
//

import SwiftUI

struct ChapterItemView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("Chapter 1")
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(.white.opacity(0.8))
                Text("Phản ứng oxi - hoá khử")
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
                Image("chapterBG")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 120)
                    .blur(radius: 2)
                    .clipped()
                Color.gray.opacity(0.3)
            }
                .cornerRadius(16)
        )

    }
}

private extension ChapterItemView {
    var playVideoButtonView: some View {
        Image("play")
            .resizable()
            .scaledToFit()
            .frame(width: 40, height: 40)
            .padding(8)
    }
}

struct ChapterItemView_Previews: PreviewProvider {
    static var previews: some View {
        ChapterItemView()
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
            .previewDisplayName("Default preview")
            .background(Color.red.opacity(0.6))
    }
}
