//
//  ImageFromURLView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 14/11/2022.
//

import SwiftUI

struct ImageFromUrlView: View {
    private let isClearBackground: Bool
    private let imageURL: String

    init(image: String, isClearBackground: Bool = true) {
        self.isClearBackground = isClearBackground
        imageURL = image
    }

    var body: some View {
        AsyncImage(url: URL(string: imageURL)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)

        } placeholder: {
            if isClearBackground {
                Color.clear
            } else {
                Color.black.opacity(0.2)
                    .shimmerAnimation()
            }
        }
    }
}
