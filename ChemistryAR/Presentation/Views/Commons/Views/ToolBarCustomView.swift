//
//  ToolBarCustomView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 31/10/2022.
//

import SwiftUI

struct ToolBarCustomView: View {
    let title: String?
    let rightButtonImage: String?
    let leftButtonAction: (() -> Void)?
    let rightButtonAction: (() -> Void)?

    init(
        title: String? = nil,
        rightButtonImage: String? = nil,
        leftButtonAction: (() -> Void)? = nil,
        rightButtonAction: (() -> Void)? = nil
    ) {
        self.title = title
        self.rightButtonImage = rightButtonImage
        self.leftButtonAction = leftButtonAction
        self.rightButtonAction = rightButtonAction
    }

    var body: some View {
        HStack {
            Button {
                leftButtonAction?()
            } label: {
                Image(systemName: "list.dash")
                    .resizable()
                    .scaledToFill()
                    .scaleEffect(0.76)
                    .frame(width: 30, height: 24)
                    .padding(.leading, 16)
            }
            .foregroundColor(.black)
            Spacer()
            Text(title ?? "")
                .font(.system(size: 22, weight: .medium))
            Spacer()
            Button {
                rightButtonAction?()
            } label: {
                Image(rightButtonImage ?? "")
                    .resizable()
                    .renderingMode(.template)
                    .squareFrame(28)
                    .padding(.trailing, 16)
            }
            .foregroundColor(.black)
            .opacity(rightButtonImage == nil ? 0 : 1)
        }
    }
}
