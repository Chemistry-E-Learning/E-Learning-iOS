//
//  CarouselItemView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 04/12/2022.
//

import SwiftUI

struct CarouselItemView: View {
    let model: CarouselViewEntity
    let size: CGSize

    var body: some View {
        ImageFromUrlView(image: model.mainImageURL)
            .frame(width: size.width - 80, height: 240)
            .clipped()
            .redacted(if: model.mainImageURL.isEmpty)
            .overlay(
                HStack {
                    VStack(alignment: .leading) {
                        Text(model.title)
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                            .lineLimit(2)
                        Spacer()
                        Text(model.author ?? AppConstant.NoContent)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white.opacity(0.6))
                            .lineLimit(2)
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    .padding(.bottom, 20)
                    .frame(height: 100)
                    Spacer()
                }
                    .background(
                        ZStack {
                            Color.white.opacity(0.4).blur(radius: 1)
                            Color.black.opacity(0.5)
                        }
                    )
                , alignment: .bottom
            )
            .cornerRadius(14)
            .shadow(radius: 1)
    }
}
