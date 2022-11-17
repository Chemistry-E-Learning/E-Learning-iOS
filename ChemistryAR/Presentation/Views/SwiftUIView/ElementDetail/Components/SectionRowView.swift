//
//  SectionRowView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 15/11/2022.
//

import SwiftUI

struct SectionRowView: View {
    let isLastItem: Bool
    let isStructureImage: Bool
    let width: CGFloat
    let title: String
    let desc: String
    let image: String?

    init(
        width: CGFloat,
        title: String,
        desc: String,
        image: String? = nil,
        isLastItem: Bool = false,
        isStructureImage: Bool = false
    ) {
        self.width = width
        self.title = title
        self.desc = desc
        self.image = image
        self.isLastItem = isLastItem
        self.isStructureImage = isStructureImage
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("\(title):")
                .font(.system(size: 14))
                .foregroundColor(.black.opacity(0.7))
            if let wrappedImage = image {
                ImageFromUrlView(image: wrappedImage)
                    .frame(width: isStructureImage ? 240 : width - 64, height: isStructureImage ? 240 : 72)
                    .clipped()
            } else {
                Text(desc)
                    .font(.system(size: 16))
                    .multilineTextAlignment(.leading)
            }
            Rectangle()
                .fill(.black.opacity(0.4))
                .frame(height: 0.5)
                .padding(.top, 6)
                .opacity(isLastItem ? 0 : 1)
        }
        .padding(.horizontal, 32)
        .padding(.top, 4)
    }
}
