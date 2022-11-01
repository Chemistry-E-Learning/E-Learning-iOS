//
//  ProgramItem.swift
//  ChemistryAR
//
//  Created by NhatMinh on 09/10/2022.
//

import SwiftUI

struct ProgramItemView: View {
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    Image("atom")
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width / 2)
                        .offset(x: 20, y: 36)
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text("Lớp 8")
                        .font(.system(size: 32, weight: .medium))
                        .padding(.bottom, 8)
                    VStack(alignment: .leading, spacing: 4) {
                        Text("20 Sections - 40 Videos")
                        Text("Le lorem ipsum est, en imprimerie, une suite de mots sans signification utilisée à titre provisoire pour")
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .foregroundColor(.c4A4A4A.opacity(0.6))
                    .font(.system(size: 14, weight: .regular))
                }
                .padding(.horizontal, 16)
            }
            .frame(width: 300, height: 260)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.purple.opacity(0.22))
                    .blur(radius: 8)
                    .cornerRadius(12)
                    .offset(y: 50)
                    .shadow(color: .black.opacity(0.1), radius: 5, x: -5, y: -5)
                    .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
            )
        }
    }
}

struct ProgramItem_Previews: PreviewProvider {
    static var previews: some View {
        ProgramItemView()
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
            .previewDisplayName("Default preview")
    }
}
