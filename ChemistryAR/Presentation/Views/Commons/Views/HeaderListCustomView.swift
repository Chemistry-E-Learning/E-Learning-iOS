//
//  HeaderListCustomView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 01/11/2022.
//

import SwiftUI

struct HeaderListCustomView: View {
    @Binding var isPushToCurrentView: Bool
    let parentHeight: CGFloat

    var body: some View {
        GeometryReader { geo in
            Image("branchBG")
                .resizable()
                .scaledToFill()
                .overlay {
                    ZStack(alignment: .topLeading) {
                        Color.black.opacity(0.4)
                        VStack(alignment: .leading, spacing: 28) {
                            BackCircleButton {
                                isPushToCurrentView = false
                            }
                            .padding(.horizontal, 8)
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Inorganic Chemistry")
                                    .font(.system(size: 26, weight: .bold))
                                    .foregroundColor(.white)
                                Text("5m30s - 12 Lessons")
                                    .font(.system(size: 13, weight: .regular))
                                    .foregroundColor(.white.opacity(0.9))
                            }
                            Text("Le lorem ipsum est, en imprimerie, une suite de mots sans signification utilisée à titre provisoire pour calibrer une mise en page, le texte définitif venant pour calibrer une mise en page, le texte définitif venant")
                                .multilineTextAlignment(.leading)
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(.white)
                                .lineLimit(4)
                        }
                        .padding(.horizontal, 28)
                        .offset(y: parentHeight * 0.1)
                    }
                }
                .frame(height: parentHeight * 0.38)
                .clipped()
        }
    }
}
