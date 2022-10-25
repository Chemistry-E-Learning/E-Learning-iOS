//
//  BranchLessonItemView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 25/10/2022.
//

import SwiftUI

struct BranchLessonItemView: View {
    var body: some View {
        HStack(spacing: 16) {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .squareFrame(60)
                .overlay (
                    Text("1")
                        .foregroundColor(.black.opacity(0.7))
                        .font(.system(size: 32, weight: .bold))
                )
                .clipped()
            VStack(alignment: .leading, spacing: -2) {
                Spacer()
                Text("What is inorganic chemistry?")
                    .foregroundColor(.black.opacity(0.8))
                    .font(.system(size: 14, weight: .medium))
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
                Text("1 Min read")
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

struct BranchLessonItemView_Previews: PreviewProvider {
    static var previews: some View {
        BranchLessonItemView()
            .padding()
    }
}
