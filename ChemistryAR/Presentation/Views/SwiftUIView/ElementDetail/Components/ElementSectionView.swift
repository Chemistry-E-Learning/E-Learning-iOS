//
//  ElementSectionView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 30/10/2022.
//

import SwiftUI

struct ElementSectionView: View {
    let parentSize: CGSize
    var body: some View {
        VStack(alignment: .leading) {
            makeSectionHeaderView(image: "flask", title: "Tính Chất")
                .padding(.bottom, 8)
            ForEach(0..<4) { index in
                makeSectionRowView(
                    isLastItem: index == 3,
                    width: parentSize.width,
                    title: "Số Nguyên Tử",
                    chemotherapy: [-3, -5, 1, 2, 3]
                )
            }
        }
    }
}

private extension ElementSectionView {
    func makeSectionHeaderView(image: String, title: String) -> some View {
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

    func makeSectionRowView(
        isLastItem: Bool,
        width: CGFloat,
        title: String,
        desc: String? = nil,
        image: String? = nil,
        chemotherapy: [Int]? = nil
    ) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("\(title):")
                .font(.system(size: 14))
                .foregroundColor(.black.opacity(0.7))
            if let wrappedImage = image {
                Image(wrappedImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: width - 64, height: 72)
                    .clipped()
            } else if let wrappedChemotherapy = chemotherapy {
                makeChemotherapyView(chemotherapy: wrappedChemotherapy)
                    .padding(.leading, 6)
                    .padding(.vertical, 8)
            } else {
                Text(desc ?? AppConstant.NoContent)
                    .font(.system(size: 16))
                    .multilineTextAlignment(.leading)
            }
            Rectangle()
                .fill(.black.opacity(0.4))
                .frame(width: .infinity, height: 0.5)
                .padding(.top, 6)
                .opacity(isLastItem ? 0 : 1)
        }
        .padding(.horizontal, 32)
        .padding(.top, 4)
    }

    func makeChemotherapyView(chemotherapy: [Int]) -> some View {
        HStack(spacing: 14) {
            ForEach(chemotherapy, id: \.self) { item in
                Text( item > 0 ? "+\(item)" : "\(item)")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(.white)
                    .background(
                        Circle()
                            .fill(item > 0 ? Color.cBF2121 : Color.c225096)
                            .squareFrame(24)
                    )
            }
        }
    }
}


struct ElementSectionView_Previews: PreviewProvider {
    static var previews: some View {
        ElementSectionView(parentSize: UIScreen.main.bounds.size)
    }
}
