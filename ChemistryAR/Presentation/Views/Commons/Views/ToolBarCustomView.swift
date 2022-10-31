//
//  ToolBarCustomView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 31/10/2022.
//

import SwiftUI

struct ToolBarCustomView: View {
    @Binding var isPushToCurrentView: Bool
    let title: String?
    let rightButtonImage: String?
    let rightButtonAction: (() -> Void)?

    init(
        isPushToCurrentView: Binding<Bool>,
        title: String? = nil,
        rightButtonImage: String? = nil,
        rightButtonAction: (() -> Void)? = nil
    ) {
        _isPushToCurrentView = isPushToCurrentView
        self.title = title
        self.rightButtonImage = rightButtonImage
        self.rightButtonAction = rightButtonAction
    }

    var body: some View {
        HStack {
            BackButton(action: {
                isPushToCurrentView = false
            }, fontWeight: .medium, color: .black)
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

struct ToolBarCustomView_Previews: PreviewProvider {
    static var previews: some View {
        ToolBarCustomView(isPushToCurrentView: .constant(false), title: "Periodic", rightButtonImage: "filter")
    }
}
