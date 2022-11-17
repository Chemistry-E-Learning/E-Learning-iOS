//
//  HeaderSection.swift
//  ChemistryAR
//
//  Created by NhatMinh on 15/11/2022.
//

import SwiftUI

struct HeaderSectionView: View {
    let image: String
    let title: String

    var body: some View {
        HStack {
            Image(image)
                .resizable()
                .renderingMode(.template)
                .squareFrame(36)
            Text(title)
                .font(.system(size: 18, weight: .medium))
            Spacer()
        }
        .padding(.horizontal, 12)
        .frame(height: 68)
        .foregroundColor(.white)
        .background(Color.c2A323F.opacity(0.9))
    }
}
