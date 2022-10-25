//
//  ChapterItem.swift
//  ChemistryAR
//
//  Created by NhatMinh on 11/10/2022.
//

import SwiftUI

struct VideoItemView: View {
    var body: some View {
        HStack {
            Image(systemName: "play.fill")
                .foregroundColor(.white)
                .squareFrame(44)
                .background(
                    Color.startButton.cornerRadius(24)
                )
            VStack(alignment: .leading, spacing: 4) {
                Text("Chapter 1")
                    .foregroundColor(.gray)
                    .font(.system(size: 11, weight: .regular))
                Text("Chất, Nguyên Tử và Phân Tử")
                    .font(.system(size: 13, weight: .medium))
            }
            .padding(.leading, 4)
            Spacer()
        }
        .padding(.horizontal, 16)
        .frame(height: 72)
        .background(Color.white.cornerRadius(8))
    }
}

struct VideoItemView_Previews: PreviewProvider {
    static var previews: some View {
        VideoItemView()
            .padding()
            .background(Color.gray)
    }
}
