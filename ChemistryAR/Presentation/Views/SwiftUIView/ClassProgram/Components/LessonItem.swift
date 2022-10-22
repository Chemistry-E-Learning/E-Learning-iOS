//
//  LessonItem.swift
//  ChemistryAR
//
//  Created by NhatMinh on 11/10/2022.
//

import SwiftUI

struct LessonItem: View {
    var body: some View {
        HStack(spacing: 20) {
            Image("boyle")
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 120)
                .cornerRadius(12)
                .clipped()
                .overlay {
                    playVideoButtonView
                }
            VStack(alignment: .leading, spacing: 8) {
                Text("Lesson 01")
                    .foregroundColor(.c4A4A4A.opacity(0.8))
                    .font(.system(size: 16, weight: .light))
                Text("Phản Ứng Oxi Hoá - Khử")
                    .font(.system(size: 18, weight: .medium))
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
            }
            .padding(.top, 16)
            Spacer()
        }
        .frame(height: 120)
        .background(
            Color.white
        )
    }
}

private extension LessonItem {
    var playVideoButtonView: some View {
        Image("play")
            .resizable()
            .scaledToFit()
            .frame(width: 40, height: 40)
            .padding(8)
    }
}
struct LessonItem_Previews: PreviewProvider {
    static var previews: some View {
        LessonItem()
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
            .previewDisplayName("Default preview")
            .background(Color.red.opacity(0.6))
    }
}
