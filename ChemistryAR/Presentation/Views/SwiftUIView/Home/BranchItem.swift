//
//  BranchItem.swift
//  ChemistryAR
//
//  Created by NhatMinh on 09/10/2022.
//

import SwiftUI

struct BranchItem: View {
    var body: some View {
        VStack(alignment: .leading) {
            Image("organic")
                .resizable()
                .scaledToFill()
                .frame(height: 120)
                .cornerRadius(12, corners: [.topLeft, .topRight])
                .clipped()
            VStack(alignment: .leading) {
                Text("Organic Chemistry")
                    .font(.system(size: 16, weight: .semibold))
                    .fixedSize(horizontal: false, vertical: true)
                    .lineLimit(2)
                    .padding(.top, 8)
                Spacer()
                HStack {
                    Circle()
                        .fill(Color.c7A2F81)
                        .frame(width: 24, height: 24)
                        .overlay {
                            Image(systemName: "play.fill")
                                .foregroundColor(.white)
                                .font(.system(size: 12))
                        }
                    Text("Start the course")
                        .font(.system(size: 13, weight: .medium))
                }
                .padding(.bottom, 8)
            }
            .padding(.leading, 16)
            Spacer()
        }
        .frame(height: 216)
        .background(
            Color.white.cornerRadius(12)
        )
        .shadow(color: .black.opacity(0.08), radius: 8, x: 2, y: 2)
    }
}

struct BranchItem_Previews: PreviewProvider {
    static var previews: some View {
        BranchItem()
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
            .previewDisplayName("Default preview")
            .background(Color.red.opacity(0.6))
    }
}
