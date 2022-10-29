//
//  TagViewItem.swift
//  ChemistryAR
//
//  Created by NhatMinh on 26/10/2022.
//

import SwiftUI

struct TagView: View {
    @State var tags: [String]
    @State private var totalHeight = CGFloat.zero
    var body: some View {
        VStack {
            GeometryReader { geometry in
                self.generateContent(in: geometry)
            }
        }
        .frame(height: totalHeight)
    }


}

private extension TagView {
    func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        return ZStack(alignment: .topLeading) {
            ForEach(tags, id: \.self) { tag in
                item(for: tag)
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width) {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if tag == tags.last {
                            width = 0
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        if tag == tags.last {
                            height = 0
                        }
                        return result
                    })
            }
        }
        .background(viewHeightReader($totalHeight))
    }

    func item(for text: String) -> some View {
        Text(text)
            .foregroundColor(.black)
            .font(.system(size: 14, weight: .medium))
            .padding()
            .lineLimit(1)
            .background(Color.cFFD335)
            .frame(height: 36)
            .cornerRadius(8)
    }

    func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}
